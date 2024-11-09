extends Node2D

@export var new_music : AudioStream = null
@export var duration : float = 1.0
@export var sync_song : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if GLOBAL_MUSIC.song_playing != new_music:
		GLOBAL_MUSIC.swap_music(new_music, duration, sync_song)
		print("Changing music")
