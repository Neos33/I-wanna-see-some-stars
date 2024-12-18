extends Line2D

var make_points : bool = false
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#clear_points()
	#add_point(position)
	particles.emitting = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if points.size() > 10:
		remove_point(0)
	#if Input.is_action_just_pressed("button_jump"):
		#add_point(get_global_mouse_position())
		#print(str(get_point_count()))


func set_point(place: Vector2):
	if make_points:
		add_point(place)

func draw_points():
	make_points = true
	particles.emitting = true
	
func stop_particles():
	make_points = false
	particles.emitting = false
	timer.start(2.0)


func _on_timer_timeout() -> void:
	queue_free()
