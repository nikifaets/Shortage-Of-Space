extends "MovementState.gd"

var target

var radius = 0
var target_reached = false
var destination

func enter_state():
	
	self.target = get_parent().target
	
	target_reached = false
	destination = owner.translation
	
func move(delta):
	
	var min_dist = get_parent().min_dist
	target = get_parent().target

	if not is_instance_valid(target):
		return
		
	if not target_reached:
		
		var direction = destination - owner.translation 
		owner.translation += direction.normalized()*owner.speed*delta
	
	if owner.translation.distance_to(destination) < radius:
		
		target_reached = true
		
	if target_reached:
		
		calculate_destination()
		
func calculate_destination():
	
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var offset_x = rng.randf_range(-radius*2, radius*2)
	var offset_z = rng.randf_range(-radius*2, radius*2)
	
	var offset = Vector3(offset_x, 0, offset_z)
	
	destination = target.translation + offset
	target_reached = false
	
	
	



