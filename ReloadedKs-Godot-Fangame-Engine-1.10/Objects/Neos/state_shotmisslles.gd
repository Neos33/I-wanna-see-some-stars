extends State

@onready var missile_shot_period: Timer = $"../../MissileShotPeriod"
@onready var sword_tip: Node2D = $"../../PlaceHolderShapeBoss/RightArm/RightShoulder"

@onready var spawn_point = parent.get_parent().find_child("MissilesSpawners")
const MISSILE = preload("res://Objects/Neos/Boss/objMissile.tscn")
#@onready var boss_sprite = parent.find_child("PlaceHolderShapeBoss")
@onready var boss_sprite: Node2D = $"../../PlaceHolderShapeBoss"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var missile_amount_shot : int = 6
var current_count = 0
var start_position : Vector2 = Vector2.ZERO

func enter():
	super.enter()
	boss_sprite.scale.x = 1
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		if GLOBAL_INSTANCES.objPlayerID.global_position.x < boss_sprite.global_position.x:
			boss_sprite.scale.x = -1
	current_count = 0
	start_position = parent.position
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(parent, "position", Vector2(0, -64), 2.0).as_relative()
	
	await tween.finished
	#print("Tween finished")
	missile_shot_period.start()
	

func exit():
	super.exit()
	missile_shot_period.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_missile(spawn_position : Vector2):
	var missile = MISSILE.instantiate()
	spawn_point.add_child(missile)
	missile.global_position = spawn_position
	missile.velocity_move = Vector2(2.0 * boss_sprite.scale.x, 0)
	audio_stream_player.play()
	missile.add_to_group("Missile_from_boss")

func _on_missile_shot_period_timeout() -> void:
	if current_count < missile_amount_shot:
		create_missile(sword_tip.global_position)
		current_count += 1
	else:
		missile_shot_period.stop()
		var time_wait = get_tree().create_timer(4.0)
		await(time_wait.timeout)
		var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		tween.tween_property(parent, "position", start_position, 2.0)
		await tween.finished
		parent.next_state()
