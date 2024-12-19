extends Node2D

var HP : int = 3
@onready var snd_break: AudioStreamPlayer = $sndBreak
const OBJ_PS_BLOCK_BOUNCE = preload("res://Objects/Neos/objPSBlockBounce.tscn")

var velocity_move = Vector2.ZERO
var prev_position = Vector2.ZERO

var speed: float = 200.0
var turn_rate: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = GLOBAL_INSTANCES.objPlayerID
	if is_instance_valid(player):
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
	var ser = OBJ_PS_BLOCK_BOUNCE.instantiate()
	add_sibling(ser)
	ser.position = position

func _on_bullet_damage_body_entered(body: Node2D) -> void:
	HP -= 1
	if HP == 0:
		destroy_missile()
	
	if HP > 0:
		print("HIT")
	body.queue_free()
