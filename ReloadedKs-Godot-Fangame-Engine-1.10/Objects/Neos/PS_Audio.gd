extends AudioStreamPlayer

var music = null

const CHARGE = [preload("res://Audio/Music/Neos/Charge1.ogg"),
preload("res://Audio/Music/Neos/Charge2.ogg"),
preload("res://Audio/Music/Neos/Charge3.ogg"),
preload("res://Audio/Music/Neos/Charge4.ogg"),
preload("res://Audio/Music/Neos/Charge5.ogg"),
preload("res://Audio/Music/Neos/Charge6.ogg"),
preload("res://Audio/Music/Neos/Charge7.ogg")]

var main_music_volume = 1.6

func _ready() -> void:
	var bus_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	#volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	volume_db = linear_to_db(db_to_linear(bus_music_volume) * main_music_volume)
	
func _process(delta: float) -> void:
	var bus_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	#volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	volume_db = linear_to_db(db_to_linear(bus_music_volume) * main_music_volume)
	
func play_music():
	stream = CHARGE[randi() % CHARGE.size()]
	play()
	

func stop_music():
	stop()
	GLOBAL_MUSIC.music_resume()
