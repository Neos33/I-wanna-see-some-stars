extends State

@onready var animation : AnimationPlayer = parent.get_parent().get_node("BlockBounceSpawners/BlocksDown")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	super.enter()
	animation.play("move_down")
	
func exit():
	super.exit()
