extends AnimatableBody2D

var move_speed = -330.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.y = 0.01
	var tween = create_tween()
	tween.tween_property(self, "scale:y", 2.0, 0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += move_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
