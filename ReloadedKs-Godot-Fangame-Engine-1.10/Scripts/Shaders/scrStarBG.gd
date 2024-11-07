extends Control

@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stay_in_camera(camera_position: Vector2, camera_limits: Array):
	var mat = color_rect.material
	camera_position.x = clamp(camera_position.x, camera_limits[0] + 400, camera_limits[2] - 400)
	camera_position.y = clamp(camera_position.y, camera_limits[1] + 304, camera_limits[3] - 304)
	mat.set_shader_parameter("u_cam_offset", -camera_position / Vector2(800, 608))
