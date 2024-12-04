extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target_room = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_room(room):
	if !animation_player.is_playing():
		animation_player.play("FadeIn")
		target_room = room
		
func travel_room():
	get_tree().change_scene_to_file(target_room)
