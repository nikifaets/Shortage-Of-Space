extends Node


var direction = Vector3()
var destination = Vector3()
var course_set = false
var dist_to_target = 3
var target

func _ready():
	
	destination = get_parent().translation
	
func _physics_process(delta):
	
	if not is_instance_valid(target):
		
		stop_course()

	elif course_set:
		
		if not is_target_reached():
			
			direction = target.translation - get_parent().translation
			owner.translation += direction.normalized()*delta*owner.speed
			
		else:
			
			course_set = false
			destination = owner.translation


func go_to_target(var target):
	
	self.target = target
	set_destination(target.translation)
	
func set_destination(var destination):
	
	direction = destination - get_parent().translation
	self.destination = destination
	course_set = true
	
func is_target_reached():
	
	return get_parent().translation.distance_to(destination) <= dist_to_target

func stop_course():
	
	course_set = false
	destination = owner.translation

	
	
