@tool
extends Area2D

@export var color : Color = Color.WHITE:
	set(color_id):
		color = color_id
		$ColorRect.color = color
		
@export var trigger_id: int = 0:
	set(trigger_property_id):
		trigger_id = trigger_property_id
		#$Label.text = str(trigger_id)

@onready var color_rect: ColorRect = $ColorRect

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Engine.is_editor_hint():
		sprite_2d.queue_free()
		label.queue_free()
		
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		label.text = str(trigger_id)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().call_group("CameraRegion", "camera_setting", trigger_id)
		#if !global_trigger.has(trigger_id):
		#	global_trigger.append(trigger_id)
