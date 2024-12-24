extends Node2D

var is_active : bool = false
@onready var spawner_node = $"../Spawners"
var spawner_list : Array = []
@onready var timer: Timer = $Timer
@onready var end_survival: Timer = $EndSurvival
@onready var survival_block_way: TileMap = $"../SurvivalBlockWay"
@onready var obj_camera_focus_region_6: Node2D = $"../../../Trigger_related/CameraRegions/objCameraFocusRegion6"
@onready var obj_camera_trigger_5: Area2D = $"../../../Trigger_related/CameraTriggers/objCameraTrigger5"

@onready var spikes_survival: Node = $SpikesSurvival

@onready var ps_spikes: TileMapLayer = $SpikesSurvival/PSSpikes
@onready var animation_player: AnimationPlayer = $SpikesSurvival/AnimationPlayer
@onready var spikes_action: Timer = $SpikesSurvival/SpikesAction
@onready var survival_block_way_2: TileMap = $"../SurvivalBlockWay2"


var ps = null
const OBJ_RING_POWER_SOURCE = preload("res://Objects/Neos/objRingPowerSource.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner_list = spawner_node.get_children()
	survival_block_way_2.position.y = 1024


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detector_body_entered(body: Node2D) -> void:
	if !is_active:
		is_active = true
		print("Survival activated")
		timer.start()
		end_survival.start()
		spikes_action.start()
		survival_block_way_2.position = Vector2(-680, 152)


func _on_timer_timeout() -> void:
	get_tree().call_group("Survival_PS_objects", "erase")
	ps = OBJ_RING_POWER_SOURCE.instantiate()
	var pick_spawner = randi() % spawner_list.size()
	spawner_list[pick_spawner].add_child(ps)
	ps.add_to_group("Survival_PS_objects")
	GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)

  
func _on_end_survival_timeout() -> void:
	get_tree().call_group("Survival_PS_objects", "erase")
	GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBouncyBlock)
	print("END")
	timer.stop()
	survival_block_way.queue_free()
	obj_camera_trigger_5.queue_free()
	obj_camera_focus_region_6.camera_setting(5)
	survival_block_way_2.queue_free()
	
	spikes_survival.queue_free()
	


func _on_spikes_action_timeout() -> void:
	animation_player.play("SpikesUpDown")
