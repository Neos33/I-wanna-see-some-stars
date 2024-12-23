extends Node2D

var camera = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid(GLOBAL_INSTANCES.objCameraID):
		global_position = GLOBAL_INSTANCES.objCameraID.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(GLOBAL_INSTANCES.objCameraID):
		global_position = GLOBAL_INSTANCES.objCameraID.global_position
