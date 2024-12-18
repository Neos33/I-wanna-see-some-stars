extends GPUParticles2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D


func _on_finished() -> void:
	queue_free()
	

func burst_particles():
	emitting = true
