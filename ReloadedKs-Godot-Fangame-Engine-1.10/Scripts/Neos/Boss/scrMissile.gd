extends Node2D

var HP : int = 3
@onready var snd_break: AudioStreamPlayer = $sndBreak
const OBJ_PS_BLOCK_BOUNCE = preload("res://Objects/Neos/objPSBlockBounce.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

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
