extends Node

@export_file("*.tscn") var target_room : String = ""
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const OBJ_WARP = preload("res://Objects/Room_objects/objWarp.tscn")
var active : bool = false

func next_room():
	#GLOBAL_INSTANCES.objPlayerID.position = Vector2(400, 608 - 128)
	#GLOBAL_GAME.warp_to_point = Vector2(400, 608 - 128)
	get_tree().change_scene_to_file(target_room)
	GLOBAL_GAME.is_changing_rooms = true
	#var transition = OBJ_WARP.instantiate()
	#add_child(transition)
	#transition.warp_to = target_room
	#transition.visible = false
	#transition.global_position = GLOBAL_INSTANCES.objPlayerID.global_position

func _on_trigger_boss_body_entered(body: Node2D) -> void:
	# Logic
	if !active:
		active = true
		animation_player.play("ShowBoss")
		froze_player()
		
func froze_player():
	GLOBAL_INSTANCES.objPlayerID.velocity.x = 0
	GLOBAL_INSTANCES.objPlayerID.frozen = true
