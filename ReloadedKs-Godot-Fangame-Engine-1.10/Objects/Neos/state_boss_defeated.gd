extends State
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var collision_polygon_2d: CollisionPolygon2D = $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand/Sword/SwordHitbox/CollisionPolygon2D"

var time : int = 0
@onready var robot_layer: CanvasGroup = $"../../RobotPart/Robot/RobotLayer"

@onready var right_spikes: Array = [$"../../PlaceHolderShapeBoss/RightArm/TilSpikes", $"../../PlaceHolderShapeBoss/RightArm/TilSpikes3", $"../../PlaceHolderShapeBoss/RightArm/TilSpikes4", $"../../PlaceHolderShapeBoss/RightArm/RightForeArm/TilSpikes5", $"../../PlaceHolderShapeBoss/RightArm/RightForeArm/TilSpikes6", $"../../PlaceHolderShapeBoss/RightArm/RightForeArm/RightHand2", $"../../PlaceHolderShapeBoss/RightArm/RightShoulder"]
@onready var left_spikes: Array = [$"../../PlaceHolderShapeBoss/LeftArm/TilSpikes", $"../../PlaceHolderShapeBoss/LeftArm/TilSpikes3", $"../../PlaceHolderShapeBoss/LeftArm/TilSpikes4", $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/TilSpikes5", $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/TilSpikes6", $"../../PlaceHolderShapeBoss/LeftArm/LeftForeArm/LeftHand", $"../../PlaceHolderShapeBoss/LeftArm/LeftShoulder"]
@onready var head: Node2D = $"../../PlaceHolderShapeBoss/Head"


var destroyed : bool = false

func enter():
	super.enter()
	get_tree().call_group("Missile_from_boss", "queue_free")
	get_tree().call_group("Aim_from_boss", "queue_free")
	timer.start()
	timer_2.start()
	destroyed = true
	collision_polygon_2d.disabled = true
	GLOBAL_MUSIC.change_volume(0.0, 1.0)
	
func exit():
	super.exit()
	timer.stop()
	collision_polygon_2d.disabled = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if destroyed:
		robot_layer.rotation = time * delta * 10.0
		robot_layer.position.y += delta
		time += 1
	
	




func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Rooms/Game/r_clear_screen.tscn")
	GLOBAL_GAME.is_changing_rooms = true


func _on_timer_2_timeout() -> void:
	timer.start(5.0)
	var total = right_spikes.size()
	for i in total:
		right_spikes[i].queue_free()
		left_spikes[i].queue_free()
	var tween = create_tween()
	tween.tween_property(head, "position:y", 216, 2.0)
	
		
