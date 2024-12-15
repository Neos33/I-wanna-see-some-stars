extends AudioStreamPlayer

var song_playing: AudioStream = null
var song_id: AudioStream = null
var loop_start: float = 0.0
var loop_end: float = 0.0

enum MUSIC_MODE {PLAYING, PAUSED, STOPPED, SWITCHING, MUTED}

var current_music_mode = null
var main_music_volume = 0.0
var song_index_selection : int = 0

# Music should keep on playing/processing even if the game is paused
func _ready():
	process_mode = PROCESS_MODE_ALWAYS
	main_music_volume = 1.0


# Updates the volume level from the "Music" audio bus. Also checks if the music
# is paused or not
func _physics_process(_delta):
	
	if current_music_mode == MUSIC_MODE.PLAYING:
		var bus_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
		#volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
		volume_db = linear_to_db(db_to_linear(bus_music_volume) * main_music_volume)
		# For pausing or resuming the music. Check scrGlobalGame
		set_stream_paused(!GLOBAL_GAME.music_is_playing)
	

	# Set the start and end positions for the music loop
	set_loop_positions()



# Checks if song_playing is the same as song_id. If this is the case, then its
# song_playing value gets replaced and streamed. If we warp to a different room
# with the same song_id, it keeps playing the same song and doesn't reset it
func music_update_and_play() -> void:
	if song_playing != song_id:
		song_playing = song_id
		
		autoplay = true
		stream = song_playing
		play()
		
		current_music_mode = MUSIC_MODE.PLAYING


# If we set a loop end position from objMusicPlayer, we then set the playback
# position once we reach the loop end position, and loop between those points
func set_loop_positions():
	if loop_end != 0.0:
		if get_playback_position() > loop_end:
			seek(loop_start)
			

func music_pause():
	if current_music_mode == MUSIC_MODE.PLAYING:
		current_music_mode = MUSIC_MODE.PAUSED
		set_stream_paused(true)

func music_resume():
	if current_music_mode == MUSIC_MODE.PAUSED:
		current_music_mode = MUSIC_MODE.PLAYING
		set_stream_paused(false)
		
func swap_music(new_audio_file : AudioStream, duration : float = 1.0, sync_song : bool = false):
	if current_music_mode == MUSIC_MODE.PLAYING:
		current_music_mode = MUSIC_MODE.SWITCHING # Change mode
		
		var _get_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
		var _volume_mute = linear_to_db(0.05)
		var track_position = get_playback_position()
		
		var aux_music : AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(aux_music)
		aux_music.volume_db = _volume_mute # Mute
		aux_music.stream = new_audio_file
		if !sync_song:
			track_position = 0.0
			
		# Play song
		aux_music.play(track_position)
		var _tween = create_tween()
		_tween.set_parallel(true)
		_tween.tween_property(self, "volume_db", _volume_mute, duration)
		_tween.tween_property(aux_music, "volume_db", _get_volume, duration)
		
		await(_tween.finished)
		
		# Swap songs finished
		print("Swap musics done")
		
		volume_db = _get_volume
		stream = new_audio_file
		song_playing = stream
		play(aux_music.get_playback_position())
		aux_music.stream = null
		aux_music.stop()
		
		# Destroy added audio
		aux_music.queue_free()
		
		# Set current mode to PLAYING
		current_music_mode = MUSIC_MODE.PLAYING
		
func change_volume(volume : float, duration : float = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "main_music_volume", volume, duration)
	await tween.finished
	main_music_volume = volume
	
func fade_out_and_stop(duration : float = 1.0):
	var tween = create_tween()
	tween.tween_property(self, "main_music_volume", 0.0, duration)
	await tween.finished
	# Stop music
	stop()
	stream = null
	song_playing = null
	main_music_volume = 1.0
