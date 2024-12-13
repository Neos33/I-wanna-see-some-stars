@tool
extends ColorRect

@export_range(0.0, 20.0, 0.1) var smoke_alpha : float = 0.4


var shader_material = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shader_material = material
	shader_material.set_shader_parameter("smoke_color", color)
	shader_material.set_shader_parameter("alpha_set", smoke_alpha)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		shader_material.set_shader_parameter("smoke_color", color)
		shader_material.set_shader_parameter("alpha_set", smoke_alpha)
