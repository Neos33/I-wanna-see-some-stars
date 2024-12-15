extends State
@onready var shield_collision: CollisionShape2D = $"../../PlaceHolderShapeBoss/ShieldHitbox/CollisionShape2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func enter():
	super.enter()
	shield_collision.disabled = false
	
func exit():
	super.exit()
	shield_collision.disabled = true
	

func _on_shield_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		body.queue_free()
