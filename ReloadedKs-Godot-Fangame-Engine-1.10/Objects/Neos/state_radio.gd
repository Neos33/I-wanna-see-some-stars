extends State

@onready var spawn_point = parent.get_parent().find_child("AimSpawners")
const OBJ_AIM_SPOT = preload("res://Objects/Neos/objAimSpot.tscn")
@onready var radio_spawn_period: Timer = $RadioSpawnPeriod
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var spawn_aims : bool = false

func enter():
	super.enter()
	radio_spawn_period.start()
	audio_stream_player.play()
	var timer = get_tree().create_timer(4.0)
	await timer.timeout
	radio_spawn_period.stop()
	var timer2 = get_tree().create_timer(4.0)
	await timer2.timeout
	#fsm.change_state("StateSummersive")
	parent.next_state()
	
func exit():
	super.exit()
	radio_spawn_period.stop()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

		

func _on_radio_spawn_period_timeout() -> void:
	var instance = OBJ_AIM_SPOT.instantiate()
	spawn_point.add_child(instance)
	instance.position = Vector2(randi_range(0, 800), randi_range(0, 128))
	instance.set_child(self)
	instance.add_to_group("Aim_from_boss")
