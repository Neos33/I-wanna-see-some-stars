extends Node2D

@onready var label: Label = $Label
@onready var shield_collision: CollisionShape2D = $Node2D/ShieldHitbox/CollisionShape2D
@onready var audio_ai_singing: AudioStreamPlayer2D = $AudioAISinging

var HP : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "HP: " + str(HP)
	# Enable shield
	if HP == 0:
		shield_collision.disabled = false
		if !audio_ai_singing.playing:
			audio_ai_singing.play()


func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		if HP > 0:
			HP -= 1
			GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndHit)
		
		body.queue_free()


func _on_shield_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		body.queue_free()
