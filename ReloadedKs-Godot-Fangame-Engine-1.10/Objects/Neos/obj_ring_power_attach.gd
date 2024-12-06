extends Node2D

@onready var ring_toggle: AnimationPlayer = $RingToggle
@onready var toggle_visibility_timer: Timer = $ToggleVisibilityTimer
@onready var ring: Sprite2D = $Ring


var time : float = 0
var time_speed : float = 0.1
var player = null
var percentage : float = 0.0
var start_position = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = GLOBAL_INSTANCES.objPlayerID
	if is_instance_valid(player):
		pass
		#var tween = create_tween()
		#tween.tween_property(self, "percentage", 1.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(player):
		percentage = 1.0
		#position = lerp(start_position, GLOBAL_INSTANCES.objPlayerID.position-global_position, percentage) 
		#position = player.position - global_position
		pass
	
	
func destroy_attach():
	GLOBAL_INSTANCES.objPlayerID.modulate = Color.WHITE
	GLOBAL_MUSIC.music_resume()
	queue_free()
	
func activate():
	print("ACTIVATED")
	if !ring_toggle.is_playing():
		ring_toggle.play("ToggleVisibility")
	

func toggle_speed(speed : float = 0.5):
	toggle_visibility_timer.start(speed)

func stop_toggle():
	destroy_attach()
	
func _on_toggle_visibility_timer_timeout() -> void:
	ring.visible = !ring.visible
