extends Camera2D

@export var target_node: Node = null

# Zoom related variables. You can ignore the global zoom from the settings and
# add the zoom amount manually
@export_category("Zoom")
@export var ignore_global_zoom: bool = false
@export var manual_zoom_amount: Vector2 = Vector2.ONE

# The big numbers inside of these variables means the camera will scroll freely
# inside of a room, without any border limit.
# If you want the camera to stop at a certain point, you set the limits inside
# of each room in the object's properties
@export_category("Border Limits")
@export var stop_left_at: int = -10000000
@export var stop_up_at: int = -10000000
@export var stop_right_at: int = -10000000
@export var stop_down_at: int = -10000000

@export_category("Camera limits")
@export var camera_limit_left: int = -10000000
@export var camera_limit_top: int = -10000000
@export var camera_limit_right: int = 10000000
@export var camera_limit_bottom: int = 10000000

@onready var timer: Timer = $Timer

var focus_speed: float = 0.1
var get_xy: Vector2 = Vector2.ZERO

var target_position : Vector2 = Vector2.ZERO
var target_zoom : Vector2 = Vector2.ONE

var snap_to_target : bool = true

var magnitude : Vector2 = Vector2(0.0, 4.0)


func _ready():
		if GLOBAL_INSTANCES.objCameraID == null or GLOBAL_INSTANCES.objCameraID != self:
			GLOBAL_INSTANCES.objCameraID = self
			
		timer.start()
		# Gets camera target (player object, mostly)
		# We know from objPlayerStart that objPlayer gets created alongside
		# this camera object, so we just check in there if it actually exists
		if is_instance_valid(target_node):
			position = target_node.position
			
			call_deferred("apply_movement")
			position = GLOBAL_GAME.camera_position_global
			
		else:
			target_node = self
		
		# Camera zoom at start
		if !ignore_global_zoom:
			zoom = Vector2(GLOBAL_SETTINGS.ZOOM_SCALING, GLOBAL_SETTINGS.ZOOM_SCALING)
		else:
			zoom = manual_zoom_amount
		
		# Invisible sprite, just for room creation
		$Sprite2D.visible = false
		
		# Sets the camera's limits
		for limit_array_1 in 4:
			var limit_array_2 = [stop_left_at, stop_up_at, stop_right_at, stop_down_at]
			set_limit(limit_array_1, limit_array_2[limit_array_1])
	
		change_magnitude(Vector2(0.0, 2.0), 0.4)
		
func change_magnitude(screenshake_magnitude : Vector2, duration : float):
	var tween = create_tween()
	tween.tween_property(self, "magnitude", screenshake_magnitude, duration)
	tween.tween_property(self, "magnitude", Vector2.ZERO, duration)


# Updates the camera target
func _physics_process(_delta):
	
	# Godot's "instance_exists"
	# Gets objPlayer's position, stores it on a local variable, follows it while
	# adding some linear interpolation
	if is_instance_valid(target_node):
		apply_movement()
		#get_xy = target_node.position
		#get_xy.x = clamp(get_xy.x, camera_limit_left, camera_limit_right)
		#get_xy.y = clamp(get_xy.y, camera_limit_top, camera_limit_bottom)
		#target_position = lerp(target_position, get_xy, focus_speed)
		#
		#if snap_to_target:
			#position = get_xy
			#target_position = get_xy
	#
		#position = target_position
		#position = lerp(position, target_node.position, focus_speed)
	else:
		
		# If the player no longer exists, it gets the values of the variable
		# get_xy, which no longer updates, but it still stored the player's
		# last position, so we continue lerping to it
		position = lerp(position, get_xy, focus_speed)
	
	
func apply_movement():
	get_xy = target_node.position
	get_xy.x = clamp(get_xy.x, camera_limit_left, camera_limit_right)
	get_xy.y = clamp(get_xy.y, camera_limit_top, camera_limit_bottom)
	
	#target_position = lerp(target_position, get_xy + Vector2(off_x, off_y), focus_speed)
	target_position = lerp(target_position, get_xy, focus_speed)
	
	# Screenshake
	var off_x = randi_range(-magnitude.x, magnitude.x)
	var off_y = randi_range(-magnitude.y, magnitude.y)
	#target_position += Vector2(off_x, off_y)
	offset = Vector2(off_x, off_y)
	
	
	if snap_to_target:
		position = get_xy
		target_position = get_xy

	position = target_position
	GLOBAL_GAME.camera_position_global = position
	
func camera_change_limits(left, top, right, bottom, zoom_level : Vector2 = Vector2.ONE):
	var ratio = Vector2(800, 608) / (zoom_level * 2)
	camera_limit_left = left + ratio.x
	camera_limit_top = top + ratio.y
	camera_limit_right = right - ratio.x
	camera_limit_bottom = bottom - ratio.y
	
	if target_zoom != zoom_level:
		target_zoom = zoom_level
		
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "zoom", target_zoom, 2.0)


func _on_timer_timeout() -> void:
	snap_to_target = false
