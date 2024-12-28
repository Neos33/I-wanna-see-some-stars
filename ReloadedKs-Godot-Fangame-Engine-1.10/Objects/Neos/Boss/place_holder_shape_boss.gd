extends Node2D

signal boss_damage(bullet : Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_hitbox_body_entered(body: Node2D) -> void:
	emit_signal("boss_damage", body)
	
