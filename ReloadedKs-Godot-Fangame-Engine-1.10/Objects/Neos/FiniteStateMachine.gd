extends Node2D

@export var controlled_object : Node

var current_state : State
var previous_state : State

func _ready() -> void:
	current_state = get_child(6) as State
	previous_state = current_state
	current_state.enter()
	
func change_state(state):
	current_state = find_child(state) as State
	if current_state == null:
		prints(current_state.name, " not found")
	else:
		#current_state = get_child(state) as State
		current_state.enter()
		
		previous_state.exit()
		
		prints("State changed from {",previous_state.name,"} to {", current_state.name, "}")
		previous_state = current_state
	
	
