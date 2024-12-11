@tool
extends Area2D

var global_trigger : Array = []

@onready var color_rect: ColorRect = $ColorRect

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

@export var color : Color = Color.WHITE:
	set(color_id):
		color = color_id
		color_rect.color = color
		
@export var trigger_id: int = 0:
	set(trigger_property_id):
		trigger_id = trigger_property_id
		label.text = str(trigger_id)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Engine.is_editor_hint():
		sprite_2d.queue_free()
		label.queue_free()
		
	# Be careful when you use @tool. Make sure this is set only when the
	# game is running, and not in the editor
	global_trigger = GLOBAL_GAME.triggered_events


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		label.text = str(trigger_id)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !global_trigger.has(trigger_id):
			global_trigger.append(trigger_id)
