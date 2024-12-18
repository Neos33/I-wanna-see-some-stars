extends Node2D

@onready var camera_regions: Node2D = $Room_related/CameraRegions
@onready var camera_dynamic: Camera2D = $Room_related/objCameraDynamic

@onready var color_rect: ColorRect = $ColorRect
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var color_rect_3: ColorRect = $ColorRect3
@onready var color_rect_4: ColorRect = $ColorRect3/ColorRect

@onready var aim_spawners: Node2D = $AimSpawners


var camera_list : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBAL_INSTANCES.Main_Scene = self
	print(GLOBAL_INSTANCES.Main_Scene)
	camera_list = camera_regions.get_children()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_obj_gundam_boss_camera_mode_switch(camera_index: int) -> void:
	camera_list[camera_index].camera_setting(0)
