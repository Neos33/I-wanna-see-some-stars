extends State

@onready var place_holder_shape_boss: Node2D = $"../../PlaceHolderShapeBoss"
@onready var sword_collision: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/RightHand/Sword/SwordHitbox/CollisionPolygon2D"
@onready var sword_tip: Node2D = $"../../PlaceHolderShapeBoss/RightHand/Sword/SwordTip"
@onready var sword: Polygon2D = $"../../PlaceHolderShapeBoss/RightHand/Sword"
@onready var right_hand: Ellipse = $"../../PlaceHolderShapeBoss/RightHand"

const SWORD_TIP_LINE_CURVE = preload("res://Objects/Neos/Boss/objSwordTipLineCurve.tscn")
var effect = null
var do_effect : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if do_effect:
		if effect != null:
			#effect.set_point(polar(sword.position))
			var spawn = sword_tip.position.rotated(sword.rotation)
			effect.set_point(spawn)
			effect.particles.position = spawn
		
	

func enter():
	super.enter()
	effect = SWORD_TIP_LINE_CURVE.instantiate()
	right_hand.add_child(effect)
	
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
	super.exit()
	sword_collision.disabled = true
	
func make_effect():
	if effect != null:
		effect.draw_points()
		do_effect = true

func stop_effect():
	if effect != null:
		effect.stop_particles()
