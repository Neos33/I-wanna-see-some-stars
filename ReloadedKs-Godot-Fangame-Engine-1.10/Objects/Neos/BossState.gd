extends Node2D
class_name State

@onready var player = GLOBAL_INSTANCES.objPlayerID
@onready var current_scene = GLOBAL_INSTANCES.Main_Scene
@onready var debug_test: Label = owner.find_child("DebugStateName")
@onready var animation_player: AnimationPlayer = owner.find_child("AnimationPlayer")

@onready var parent = get_parent().controlled_object
@onready var fsm = get_parent()

#var parent = null

func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	
func exit() -> void:
	set_physics_process(false)
	
func transition():
	pass

func _physics_process(delta: float) -> void:
	transition()
	debug_test.text = name
