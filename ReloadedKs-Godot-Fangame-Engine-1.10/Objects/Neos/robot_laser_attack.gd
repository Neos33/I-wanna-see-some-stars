extends Node2D

@export var trigger_id : int = 0

@onready var spike: Node2D = $Spike
@onready var robot: Sprite2D = $RobotBackground/Robot

@onready var attack_animation: AnimationPlayer = $RobotBackground/AttackAnimation
@onready var robot_movement: AnimationPlayer = $RobotMovement


@onready var prepare_attack: Timer = $PrepareAttack

@onready var spawn_particles: Node2D = $SpawnParticles

@onready var smoke: GPUParticles2D = $SpawnParticles/Smoke
@onready var explosion: GPUParticles2D = $SpawnParticles/Explosion
@onready var explosion_collider: CollisionShape2D = $SpawnParticles/AreaExplosionKiller/ExplosionCollider

@onready var laser_vision_sound: AudioStreamPlayer = $LaserVisionSound
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

@onready var sound_overlap: Timer = $SoundOverlap

var explosion_spam_sound : bool = false
var triggered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GLOBAL_GAME.triggered_events.has(trigger_id) and !triggered:
		var tween = create_tween()
		var duration = 3.0
		tween.tween_property(spike, "position:y", -32, duration)
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndCherry)
		triggered = true
		await tween.finished
		robot_movement.play("RobotBackgroundFall")
	
	if explosion_spam_sound:
		explosion_sound.play()
	


# Explosion in action
func explode_ground():
	#explosion_spam_sound = true
	sound_overlap.start()
	
	smoke.emitting = true
	explosion.emitting = true
	explosion_collider.disabled = false
	
	spawn_particles.position.x = GLOBAL_INSTANCES.objPlayerID.position.x - 400
	spawn_particles.position.y = 608 - 32 # Ground


func _on_explosion_finished() -> void:
	explosion_spam_sound = false
	sound_overlap.stop()
	explosion_collider.disabled = true


# Laser vision
func _on_prepare_attack_timeout() -> void:
	laser_vision_sound.play()
	attack_animation.play("Laser")


# Laser finished, robot goes up
func _on_attack_animation_animation_finished(anim_name: StringName) -> void:
	robot_movement.stop()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(robot, "position:y", -32, 3.0)
	


func _on_robot_movement_animation_finished(anim_name: StringName) -> void:
	if anim_name == "RobotBackgroundFall":
		robot_movement.play("RobotBackgroundWave")
		prepare_attack.start()
		


func _on_sound_overlap_timeout() -> void:
	explosion_sound.play()
