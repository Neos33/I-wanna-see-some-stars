extends Node2D

#const OBJ_AIM_VISUAL_EXPLOSION = preload("res://Objects/Neos/objAimVisualExplosion.tscn")
var explosion = null
var parent = null
var parent_pos = Vector2.ZERO
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var obj_aim_visual_explosion: Node2D = $objAimVisualExplosion

func _ready():
	var tween = create_tween()
	var off_x = randi_range(-32, 32)
	var off_y = randi_range(-32, 32)
	var target = Vector2(off_x, off_y)
	tween.tween_property(self, "position", target, 2.0).as_relative()
	
func boom():
	obj_aim_visual_explosion.animation_player.play("Boom")
	obj_aim_visual_explosion.visible = true
	obj_aim_visual_explosion.collision_shape_2d.disabled = false
	#if explosion == null and parent != null:
		#explosion = OBJ_AIM_VISUAL_EXPLOSION.instantiate()
		##explosion.position = position #global_position
		#
		#add_child(explosion)
		##visible = false

func set_child(parent_instance: Node):
	parent = parent_instance
	parent_pos = parent_instance.position

func _on_timer_timeout() -> void:
	boom()
	animation_player_2.play("FadeOut")
