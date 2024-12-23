extends Node2D
@onready var explosion_fx: GPUParticles2D = $GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	explosion_fx.emitting = true

func _on_gpu_particles_2d_finished() -> void:
	queue_free()
