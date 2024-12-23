extends Node2D

var HP : int = 3
@onready var snd_break: AudioStreamPlayer = $sndBreak
const MISSILE_EXPLOSION = preload("res://Objects/Neos/Boss/missile_explosion.tscn")
@onready var timer: Timer = $Timer
@onready var missile_sprite: Sprite2D = $MissileSprite
@onready var missile_trail: GPUParticles2D = $MissileTrail

var velocity_move = Vector2.ZERO
var prev_position = Vector2.ZERO

var speed: float = 200.0
var turn_rate: float = 3.0

var in_motion : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = GLOBAL_INSTANCES.objPlayerID
	if is_instance_valid(player) and in_motion:
		# Dirección actual del misil
		var current_direction = velocity_move.normalized()
		# Dirección hacia el jugador
		var target_direction = (player.global_position - global_position).normalized()
		# Interpolar suavemente entre la dirección actual y la dirección hacia el jugador
		var new_direction = current_direction.lerp(target_direction, turn_rate * delta).normalized()
		
		# Actualizar la velocidad en la nueva dirección
		velocity_move = new_direction * speed * delta
		
	# Mover el misil
	global_position += velocity_move
	
	# Rotar el misil hacia la dirección de movimiento
	rotation = velocity_move.angle()

		

# Play sound from the global singleton and free the node
func destroy_missile():
	#snd_break.play()
	GLOBAL_SOUNDS.play_sound(snd_break.stream)
	queue_free()
	

func _on_wall_detect_body_entered(body: Node2D) -> void:
	destroy_missile()
	var ser = MISSILE_EXPLOSION.instantiate()
	add_sibling(ser)
	ser.position = position

func _on_bullet_damage_body_entered(body: Node2D) -> void:
	HP -= 1
	if HP == 0:
		destroy_missile()
	
	if HP > 0:
		print("HIT")
	body.queue_free()


func _on_timer_timeout() -> void:
	in_motion = true
	#var tween = create_tween()
	var col = "ff7878"
	missile_sprite.modulate = col
	missile_trail.emitting = true
	#tween.tween_property(missile_sprite, "modulate", col,  0.5)
	timer.queue_free()
