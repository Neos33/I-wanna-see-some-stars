extends State

var underground : bool = false
var time : float = 0.0
var speed_wave = 0.0
var going_back : bool = false
var start_position : Vector2 = Vector2.ZERO

@onready var summersive_arrive: Timer = $"../../SummersiveArrive"
@onready var boss_sprite = parent.find_child("PlaceHolderShapeBoss")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition():
	pass

func enter():
	super.enter()
	start_position = parent.position
	animation_player.play("summersive_ground")
	speed_wave = randf_range(0.5, 1.3)
	
func exit():
	super.exit()
	parent.rotation = 0
	
func _process(delta: float) -> void:
	if underground:
		parent.position.x = 400 + sin(time * speed_wave) * 370
		time += delta
		
	# Flip sprite
	if going_back:
		boss_sprite.scale.x = 1
		if is_instance_valid(player):
			if player.position.x < parent.position.x:
				boss_sprite.scale.x = -1
		
	
func going_down():
	# Move down behind the ground
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(parent, "position:y", 608 + 48, 2.0)
	await (tween.finished)
	
	# Change camera focus
	parent.emit_signal("camera_mode_switch", 1)
	
	underground = true
	summersive_arrive.start(randf_range(15.0, 25.0))
	parent.position.y = 608
	
	# AI singing
	parent.summersive_music_singing(1.0, 1.0)
	#fsm.change_state("StateShield")


func _on_summersive_arrive_timeout() -> void:
	underground = false
	going_back = true
	boss_sprite.rotation = 0
	parent.summersive_music_stop()
	
	# Delay
	var timer = get_tree().create_timer(1.5)
	await timer.timeout
	
	# Move up
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(parent, "position:y", start_position.y, 1.5)
	
