extends Node2D

@onready var player = GLOBAL_INSTANCES.objPlayerID
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_instance_valid(player):
		position = player.position
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(GLOBAL_INSTANCES.objPlayerID):
		position = GLOBAL_INSTANCES.objPlayerID.position
