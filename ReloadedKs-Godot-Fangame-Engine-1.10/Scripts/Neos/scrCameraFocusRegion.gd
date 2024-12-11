extends Node2D

@export var camera_index : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func camera_setting(number_id : int):
	if number_id == camera_index:
		GLOBAL_INSTANCES.objCameraID.camera_change_limits(position.x, position.y, position.x + scale.x * 32, position.y + scale.y * 32)
	
