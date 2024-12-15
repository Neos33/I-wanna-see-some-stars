extends CharacterBody2D

@onready var HP_text: Label = $HPText
@onready var shield_collision: CollisionShape2D = $PlaceHolderShapeBoss/ShieldHitbox/CollisionShape2D
@onready var audio_ai_singing: AudioStreamPlayer2D = $AudioAISinging
@onready var FSM: Node2D = $FiniteStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum ATTACK_MODE {SUMMERSIVE, RADIO, APPROCH, SHIELD}
var attack_mode = ATTACK_MODE.SUMMERSIVE
var cooldown_attack_finished = 5.0

var HP : int = 10
var HP_intermission : int = 2

signal camera_mode_switch(camera_index : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HP_text.text = "HP: " + str(HP)
	# Enable shield
	if HP == HP_intermission:
		if attack_mode == ATTACK_MODE.SUMMERSIVE:
			switch_state(ATTACK_MODE.SHIELD)
			#summersive_music_singing(3.0, 1.0)
			emit_signal("camera_mode_switch", 1)
			#shield_mode(true)
			

func switch_state(state):
	if attack_mode != state:
		FSM.change_state(state)
		attack_mode = state

func shield_mode(mode : bool = true):
	shield_collision.disabled = !mode

func summersive_music_singing(duration : float = 1.0, lower_volume_duration : float = 1.0):
	if !audio_ai_singing.playing:
		GLOBAL_INSTANCES.objPlayerID.player_listener.make_current()
		
		audio_ai_singing.play()
		GLOBAL_MUSIC.change_volume(0.3, lower_volume_duration)
		
		audio_ai_singing.max_distance = 3000
		audio_ai_singing.panning_strength = 1
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(audio_ai_singing, "max_distance", 300, duration)
		tween.tween_property(audio_ai_singing, "panning_strength", 3, duration)

#region Signals
func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bullet"):
		if attack_mode != ATTACK_MODE.SHIELD:
			if HP > 0:
				HP -= 1
				GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndHit)
		
		
		body.queue_free()


#func _on_shield_hitbox_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Bullet"):
		#GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndBlockChange)
		#body.queue_free()

#endregion
