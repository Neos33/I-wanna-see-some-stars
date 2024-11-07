@tool
extends StaticBody2D

enum DIRECTION {RIGHT = 0, UP = 270, LEFT = 180, DOWN = 90}
@export var direction_target : DIRECTION

@onready var arrow: Sprite2D = $Arrow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrow.rotation = deg_to_rad(direction_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		arrow.rotation = deg_to_rad(direction_target)
