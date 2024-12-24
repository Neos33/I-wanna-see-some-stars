extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var smoke: GPUParticles2D = $Smoke
@onready var explosion: GPUParticles2D = $Explosion
@onready var explosion_trail: GPUParticles2D = $ExplosionTrail

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D


@onready var free_scene: Timer = $FreeScene
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

func burst_particles():
	smoke.emitting = true
	explosion.emitting = true
	explosion_trail.emitting = true
	free_scene.start()
	explosion_sound.play()


func _on_free_scene_timeout() -> void:
	get_parent().queue_free()
	queue_free()
