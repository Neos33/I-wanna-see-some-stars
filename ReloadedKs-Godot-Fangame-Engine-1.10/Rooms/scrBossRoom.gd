extends Node2D

@onready var camera_regions: Node2D = $Room_related/CameraRegions
@onready var camera_dynamic: Camera2D = $Room_related/objCameraDynamic

var camera_list : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_list = camera_regions.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_obj_gundam_boss_camera_mode_switch(camera_index: int) -> void:
	camera_list[camera_index].camera_setting(0)
