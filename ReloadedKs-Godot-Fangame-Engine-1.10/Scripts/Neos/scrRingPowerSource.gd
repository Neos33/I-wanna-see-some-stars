extends Area2D

@export var color : Color = Color.WHITE

@onready var toggle_visibility_timer: Timer = $ToggleVisibilityTimer

@onready var ring_gradient_animate: AnimationPlayer = $RingGradientAnimate
@onready var ring_expand: AnimationPlayer = $RingExpand
@onready var ring: Sprite2D = $Ring

@onready var music_source: AudioStreamPlayer = $MusicSource
@onready var charge_sound: AudioStreamPlayer = $ChargeSound

const RING_POWER_ATTACH = preload("res://Objects/Neos/objRingPowerAttach.tscn")

var song_list : Array = [
	"res://Audio/Music/Neos/Charge1.ogg",
	"res://Audio/Music/Neos/Charge2.ogg",
	"res://Audio/Music/Neos/Charge3.ogg", 
	"res://Audio/Music/Neos/Charge4.ogg", 
	"res://Audio/Music/Neos/Charge5.ogg", 
	"res://Audio/Music/Neos/Charge6.ogg", 
	"res://Audio/Music/Neos/Charge7.ogg"
]

var save_time : float = 0.0
var active : bool = false

@onready var source_left: Polygon2D = $SourceLeft
@onready var source_right: Polygon2D = $SourceRight

var time : float = 0
var time_speed : float = 0.1

var power_player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_speed = 4.0
	source_left.position.y = sin(time) * 12
	source_right.position.y = sin(time + 180) * 12
	time += time_speed * delta


func toggle_speed(time : float = 0.5):
	if save_time != time:
		save_time = time
		toggle_visibility_timer.start(time)
		

func stop_toggle():
	#visible = false
	toggle_visibility_timer.stop()
	queue_free()


func _on_toggle_visibility_timer_timeout() -> void:
	visible = !visible
	

# Touch the power
func _on_area_entered(area: Area2D) -> void:
	#print("IS THIS GETTING ACTIVATED?")
	get_tree().call_group("PlayerPowerSource", "destroy_attach")
	power_player = null
	music_source.stop()
	charge_sound.play()
	GLOBAL_MUSIC.music_pause()
	
	# Create Power source attach
	power_player = RING_POWER_ATTACH.instantiate()
	power_player.call_deferred("activate")
	GLOBAL_INSTANCES.objPlayerID.add_child(power_player)
	
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		GLOBAL_INSTANCES.objPlayerID.modulate = ring.modulate
		
	GLOBAL_GAME.circuit_mode(true)
	
		#Stop charge music
	# Sound charging looping
	# Stop main music

# Not touching the power anymore, start action
func _on_area_exited(area: Area2D) -> void:
	#ring_toggle.play("ToggleVisibility")

	if power_player != null:
		power_player.call_deferred("run_countdown")

	var song_selected = song_list[randi() % song_list.size()]
	var music_pick = load(song_selected)
	music_source.stream = music_pick
	music_source.play()
	charge_sound.stop()
		
	
	#Play charge music 
	# Stop Sound charging looping

func available():
	power_player = null
	#print("Is now available")
