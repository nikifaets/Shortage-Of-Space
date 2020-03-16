extends "MovementState.gd"

var radius = 40
var target

func enter_state():
		
		self.target = get_parent().target

func move(delta):
	
	target = get_parent().target
	if not is_instance_valid(target):
		return
		
	var min_dist = get_parent().min_dist
	if owner.translation.distance_to(target.translation) < min_dist:
		
		get_parent().change_state("Maneuever") 
		
	self.target = get_parent().target
		
	var direction = target.translation - owner.translation
	owner.translation += direction.normalized()*delta*owner.speed

