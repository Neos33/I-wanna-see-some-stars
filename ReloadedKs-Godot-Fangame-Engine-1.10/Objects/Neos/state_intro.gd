extends State

@onready var timer: Timer = $Timer

func enter():
	super.enter()
	timer.start(3.0)
	
func exit():
	super.exit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	#fsm.change_state("StateRadio")
	parent.next_state()
