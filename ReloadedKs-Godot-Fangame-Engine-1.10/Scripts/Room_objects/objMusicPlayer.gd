extends Node2D

@export var song_id: AudioStream = null
@export var loop_start: float = 0.0
@export var loop_end: float = 0.0

const RES_MUSIC_INFO = preload("res://Scripts/Neos/resMusicInfo.tres")
@export var song_data : Array = [RES_MUSIC_INFO, RES_MUSIC_INFO]

func _ready():
	$Sprite2D.visible = false
	
	#GLOBAL_MUSIC.song_id = song_id
	#GLOBAL_MUSIC.loop_start = loop_start
	#GLOBAL_MUSIC.loop_end = loop_end
	#GLOBAL_MUSIC.music_update_and_play()
	var song_index_chosen = GLOBAL_MUSIC.song_index_selection
	
	GLOBAL_MUSIC.song_id = song_data[song_index_chosen].musica
	GLOBAL_MUSIC.loop_start = song_data[song_index_chosen].loop_start
	GLOBAL_MUSIC.loop_end = song_data[song_index_chosen].loop_end
	GLOBAL_MUSIC.music_update_and_play()
	
