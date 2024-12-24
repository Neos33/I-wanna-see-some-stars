extends State

@onready var animation : AnimationPlayer = parent.get_parent().get_node("BlockBounceSpawners/BlocksDown")

var start_position : Vector2 = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	super.enter()
	start_position = parent.position
	animation.play("move_down")
	var tween = create_tween()
	tween.tween_property(parent, "position", Vector2(400, 304 - 32), 1.0)
	await(tween.finished)
	parent.next_state()
	
func exit():
	super.exit()
	start_position = Vector2.ZERO
	parent.state_list.erase("StateIntermission")
	print("BORRO EL STATE?")
	print(parent.state_list)
	parent.shield_enabled = false
	parent.current_state_count -= 1
