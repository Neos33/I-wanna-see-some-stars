extends Node2D

var is_active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_detector_body_entered(body: Node2D) -> void:
	if !is_active:
		is_active = true
