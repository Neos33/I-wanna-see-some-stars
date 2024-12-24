extends State

@onready var place_holder_shape_boss: Node2D = $"../../PlaceHolderShapeBoss"
#@onready var sword_collision: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/RightHand/Sword/SwordHitbox/CollisionPolygon2D"
#@onready var sword_tip: Node2D = $"../../PlaceHolderShapeBoss/RightHand/Sword/SwordTip"
#@onready var sword: Polygon2D = $"../../PlaceHolderShapeBoss/RightHand/Sword"
#@onready var right_hand: Ellipse = $"../../PlaceHolderShapeBoss/RightHand"

@onready var sword_collision: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword/SwordHitbox/CollisionPolygon2D"
@onready var sword_tip: Node2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword/SwordTip"
@onready var sword: Polygon2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword"
@onready var right_hand: Ellipse = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand"


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var right_sword_anim: AnimationPlayer = $"../../PlaceHolderShapeBoss/RightSwordAnim"

const SWORD_TIP_LINE_CURVE = preload("res://Objects/Neos/Boss/objSwordTipLineCurve.tscn")
var effect = null
var do_effect : bool = false
var start_position : Vector2 = Vector2.ZERO
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
	start_position = parent.global_position
	effect = SWORD_TIP_LINE_CURVE.instantiate()
	right_hand.add_child(effect)
	
	sword_collision.disabled = false
	var look = 1
	if is_instance_valid(player):
		if player.position.x < parent.position.x:
			look = -1
		
	place_holder_shape_boss.scale.x = look
	
	#animation_player.play("approch_slash")
	right_sword_anim.play("ApprochSlash")
	var offset_x = 64 * -look
	if is_instance_valid(player):
		var tween = create_tween()
		tween.tween_property(parent, "position", player.position + Vector2(offset_x, 0), 1.5)
	

func finish():
	#fsm.change_state("StateShield")
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(parent, "position", start_position, 3.0)
	await tween.finished
	parent.next_state()
	
func exit():
	super.exit()
	sword_collision.disabled = true
	
func make_effect():
	if effect != null:
		effect.draw_points()
		do_effect = true
		make_sound()

func stop_effect():
	if effect != null:
		effect.stop_particles()

func make_sound():
	audio_stream_player.play()
