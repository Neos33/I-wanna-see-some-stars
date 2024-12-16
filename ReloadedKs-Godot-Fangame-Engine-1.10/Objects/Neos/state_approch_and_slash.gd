extends State

@onready var place_holder_shape_boss: Node2D = $"../../PlaceHolderShapeBoss"
@onready var sword_collision: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/RightHand/Sword/SwordHitbox/CollisionPolygon2D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func enter():
	sword_collision.disabled = false
	var look = 1
	if player.position.x < parent.position.x:
		look = -1
		
	place_holder_shape_boss.scale.x = look
	
	animation_player.play("approch_slash")
	var offset_x = 64 * -look
	var tween = create_tween()
	tween.tween_property(parent, "position", player.position + Vector2(offset_x, 0), 1.5)
	

func finish():
	fsm.change_state(3)
	
func exit():
	sword_collision.disabled = true
