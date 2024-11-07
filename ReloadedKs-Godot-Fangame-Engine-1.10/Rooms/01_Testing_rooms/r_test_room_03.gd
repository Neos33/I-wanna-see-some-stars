extends Node2D

@onready var star_bg: Control = $CanvasLayer/StarBG

@onready var obj_camera_fixed: Camera2D = $Room_related/objCameraFixed

var should_update = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	should_update = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if should_update:
		var cam_position = obj_camera_fixed.position - Vector2(400, 304)
		#star_bg.position = cam_position
		star_bg.stay_in_camera(cam_position)
