extends State


@onready var sword_hitbox: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword/SwordHitbox/CollisionPolygon2D"

@onready var summersive_arrive: Timer = $SummersiveArrive
@onready var boss_sprite = $"../../PlaceHolderShapeBoss" #parent.find_child("PlaceHolderShapeBoss")
#@onready var boss_sprite = $"../../RobotPart/Robot/RobotLayer"
@onready var summersive_animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var summersive_shot_period: Timer = $SummersiveShotPeriod



const OBJ_BOSS_LASER = preload("res://Objects/Neos/Boss/objBossLaser.tscn")
var underground : bool = false
var time : float = 0.0
var speed_wave = 0.0
var going_back : bool = false
var start_position : Vector2 = Vector2.ZERO

var underground_target_position_y : float = 608 + 368
var summersive_wave_position_y : float = 608 + 224 - 168

@onready var right_hand: Ellipse = $"../../PlaceHolderShapeBoss/RightArm/RightForeArm/RightHand2"
@onready var left_hand: Ellipse = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand"
@onready var audio_laser_shot: AudioStreamPlayer = $AudioLaserShot

func enter():
	super.enter()
	time = 0.0
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
	summersive_shot_period.stop()
	
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
	tween.tween_property(parent, "position:y", underground_target_position_y, 2.1)
	await (tween.finished)
	
	# Change camera focus
	parent.emit_signal("camera_mode_switch", 1)
	
	parent.position.x = 400
	
	
	#parent.position.y = underground_target_position_y + 224
	var tween2 = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween2.tween_property(parent, "position:y", summersive_wave_position_y, 0.5)
	await tween2.finished
	underground = true
	summersive_arrive.start(randf_range(11.0, 18.0))
	summersive_shot_period.start(randf_range(0.8, 1.4))
	
	# AI singing
	#parent.summersive_music_singing(1.0, 1.0)
	#fsm.change_state("StateShield")


func _on_summersive_arrive_timeout() -> void:
	underground = false
	going_back = true
	summersive_shot_period.stop()
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
	


func _on_summersive_shot_period_timeout() -> void:
	summersive_shot_period.start(randf_range(0.8, 1.4))
	var laser = OBJ_BOSS_LASER.instantiate()
	laser.global_position = left_hand.global_position
	parent.add_sibling(laser)
	
	
	var laser2 = OBJ_BOSS_LASER.instantiate()
	laser2.global_position = right_hand.global_position
	parent.add_sibling(laser2)
	
	audio_laser_shot.play()
	audio_laser_shot.pitch_scale = 1.0 + randf_range(-0.1, 0.1)
