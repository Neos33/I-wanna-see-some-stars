extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		position = GLOBAL_INSTANCES.objPlayerID.position
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		position = GLOBAL_INSTANCES.objPlayerID.position
