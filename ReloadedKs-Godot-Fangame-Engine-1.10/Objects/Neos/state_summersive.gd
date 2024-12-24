extends State


@onready var sword_hitbox: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword/SwordHitbox/CollisionPolygon2D"

@onready var summersive_arrive: Timer = $SummersiveArrive
@onready var boss_sprite = $"../../PlaceHolderShapeBoss" #parent.find_child("PlaceHolderShapeBoss")
#@onready var boss_sprite = $"../../RobotPart/Robot/RobotLayer"
@onready var summersive_animation: AnimationPlayer = $"../../AnimationPlayer"

var underground : bool = false
var time : float = 0.0
var speed_wave = 0.0
var going_back : bool = false
var start_position : Vector2 = Vector2.ZERO

func enter():
	super.enter()
	start_position = parent.position
	summersive_animation.play("summersive_ground")
	speed_wave = randf_range(0.5, 1.3)
	if is_instance_valid(sword_hitbox):
		sword_hitbox.disabled = true
	
func exit():
	super.exit()
	parent.rotation = 0
	#animation_player.stop()
	#animation_player.clear_queue()
	underground = false
	going_back = false
	start_position = Vector2.ZERO
	summersive_arrive.stop()
	sword_hitbox.disabled = false
	
func _process(delta: float) -> void:
	if underground:
		parent.position.x = 400 + sin(time * speed_wave) * 370
		time += delta
		
	# Flip sprite
	if going_back:
		boss_sprite.scale.x = 1
		if is_instance_valid(player):
			if player.position.x < parent.position.x:
				boss_sprite.scale.x = -1
				
		
	
func going_down():
	# Move down behind the ground
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(parent, "position:y", 608 + 128, 2.1)
	await (tween.finished)
	
	# Change camera focus
	parent.emit_signal("camera_mode_switch", 1)
	
	underground = true
	summersive_arrive.start(randf_range(11.0, 18.0))
	parent.position.y = 608 + 96
	
	# AI singing
	#parent.summersive_music_singing(1.0, 1.0)
	#fsm.change_state("StateShield")


func _on_summersive_arrive_timeout() -> void:
	underground = false
	going_back = true
	summersive_animation.play("summersive_back_normal")
	boss_sprite.rotation = 0
	#parent.summersive_music_stop()
	
	# Delay
	var timer = get_tree().create_timer(1.5)
	await timer.timeout
	
	# Move up
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position:y", start_position.y, 1.5)
	
	await tween.finished
	# Reset camera focus
	parent.emit_signal("camera_mode_switch", 3)
	var time_wait = get_tree().create_timer(2.0)
	await time_wait.timeout
	parent.next_state()
	
