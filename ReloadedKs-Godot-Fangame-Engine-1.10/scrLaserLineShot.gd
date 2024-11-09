extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ellipse: Ellipse = $Ellipse


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.add_point(Vector2.ZERO)
	line_2d.add_point(ray_cast_2d.target_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Obtener la posición global del ratón (o el punto hacia el que quieres disparar)
	var mouse = get_global_mouse_position() - position
	
	# Actualizar la posición de destino del RayCast2D (usando target_position)
	ray_cast_2d.target_position = mouse
	ellipse.position = mouse
	
	# Actualizar la línea para que se dibuje hasta el punto deseado
	line_2d.points[0] = Vector2.ZERO
	line_2d.points[1] = mouse
	
	# Comprobar si hay colisión
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		var collision_point = ray_cast_2d.get_collision_point()
		
		print("Collider detected: ", collider)
		print("Collision point: ", collision_point)
		
		# Ajustar el punto final de la línea al punto de colisión
		line_2d.points[1] = collision_point - position - line_2d.position
		ellipse.position = collision_point - position
		print("COLLIDING")
