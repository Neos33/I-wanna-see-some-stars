extends CanvasLayer

@export var game_speed: float = 0.5

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("button_down") and !animation_player.is_playing():
		animation_player.play("LinkinPark")
	
func set_motion_speed():
	## Make the game slow and pause the main music
	Engine.time_scale = game_speed
	animation_player.speed_scale = 1.0 / game_speed
	# Pause music
	GLOBAL_MUSIC.music_pause()

func resume_speed():
	## Reset speed animation and general game speed
	Engine.time_scale = 1
	animation_player.speed_scale = 1
	
	
## Reset game speed and resume the music
func finished():
	resume_speed()
	GLOBAL_MUSIC.music_resume()
	# Destroy this node
	queue_free() 
	
