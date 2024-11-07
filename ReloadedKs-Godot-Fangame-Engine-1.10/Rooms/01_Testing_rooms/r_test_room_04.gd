extends Node2D

@onready var obj_camera_dynamic: Camera2D = $Room_related/objCameraDynamic
@onready var star_bg: Control = $CanvasLayer/StarBG

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cam_position = obj_camera_dynamic.position# - Vector2(400, 304)
	var cam_limits : Array = [obj_camera_dynamic.stop_left_at, obj_camera_dynamic.stop_up_at, obj_camera_dynamic.stop_right_at, obj_camera_dynamic.stop_down_at]
	#star_bg.position = cam_position
	star_bg.stay_in_camera(cam_position, cam_limits)
