extends RayCast

onready var camera = owner.find_node("Camera")
var depth = 1000

func _ready():
	
	enabled = true
	
func _physics_process(delta):
	
	handle_input()
	
func get_cursor_coords():
	
	return to_global($Cursor.translation)
	
func handle_input():
			
	var mouse_coords = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mouse_coords)
	var normal = camera.project_ray_normal(mouse_coords)
	translation = origin
	cast_to = normal*depth
	var collider_pos = get_collision_point()
	var collider = get_collider()
	$Cursor.translation = collider_pos - translation
