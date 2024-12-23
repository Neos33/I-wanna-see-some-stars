extends CharacterBody2D

@onready var HP_text: Label = $HPText
@onready var shield_collision: CollisionShape2D = $PlaceHolderShapeBoss/ShieldHitbox/CollisionShape2D
@onready var audio_ai_singing: AudioStreamPlayer2D = $AudioAISinging
@onready var FSM: Node2D = $FiniteStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $GUI/Control/ProgressBar

enum ATTACK_MODE {SUMMERSIVE, RADIO, APPROCH, SHIELD}
var attack_mode = ATTACK_MODE.SUMMERSIVE
var cooldown_attack_finished = 5.0

var HP : int = 60
var HP_intermission : int = 20
var phase : int = 1

var state_list : Array = ["StateSummersive", "StateRadio", "StateApprochAndSlash", "StateMissiles"]
var current_state_count : int = 0

signal camera_mode_switch(camera_index : int)


func _ready() -> void:
	progress_bar.max_value = HP
	progress_bar.value = HP
	
	state_list.shuffle()


func _process(delta: float) -> void:
	HP_text.text = "HP: " + str(HP)
	progress_bar.value = HP
	
	# Enable shield
	if HP == HP_intermission:
		if phase == 1:
			switch_state("StateRadio")
			##summersive_music_singing(3.0, 1.0)
			#emit_signal("camera_mode_switch", 1)
			#phase = 2
			#shield_mode(true)
			

func switch_state(state : String):
	FSM.change_state(state)
	#attack_mode = state

func next_state():
	if current_state_count == state_list.size():
		state_list.shuffle()
		current_state_count = 0
		print("state list shuffled")
		
	FSM.change_state(state_list[current_state_count])
	current_state_count += 1
	#attack_mode = state

func shield_mode(mode : bool = true):
	shield_collision.disabled = !mode

func summersive_music_singing(duration : float = 1.0, lower_volume_duration : float = 1.0):
	if !audio_ai_singing.playing:
		if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
			GLOBAL_INSTANCES.objPlayerID.player_listener.make_current()
		
		audio_ai_singing.play()
		GLOBAL_MUSIC.change_volume(0.3, lower_volume_duration)
		
		audio_ai_singing.max_distance = 3000
		audio_ai_singing.panning_strength = 1
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(audio_ai_singing, "max_distance", 500, duration)
		tween.tween_property(audio_ai_singing, "panning_strength", 3, duration)
		
func summersive_music_stop():
	if audio_ai_singing.playing:
		audio_ai_singing.stop()
		GLOBAL_MUSIC.change_volume(1.0, 1.5)
		

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
