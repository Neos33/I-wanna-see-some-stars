extends Node2D

@export var camera_index : int = 0
@export var zoom : Vector2 = Vector2.ONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func camera_setting(number_id : int):
	if number_id == camera_index:
		GLOBAL_INSTANCES.objCameraID.camera_change_limits(position.x, position.y, position.x + scale.x * 32, position.y + scale.y * 32, zoom)
	
