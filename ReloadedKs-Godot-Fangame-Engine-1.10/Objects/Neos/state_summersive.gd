extends State


# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition():
	pass

func enter():
	animation_player.play("summersive_ground")
	
func exit():
	parent.rotation = 0
	
func going_down():
	var tween = create_tween()
	tween.tween_property(parent, "position:y", 608 + 48, 1.0)
	await (tween.finished)
	fsm.change_state(3)
