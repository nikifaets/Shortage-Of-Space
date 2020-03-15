extends "MovementState.gd"

var target
var radius
var target_reached = false
var destination
var min_dist = 3

func enter_state():
	
	self.target = get_parent().target
	self.radius = owner.find_node("Buffer", true).find_node("CollisionShape").shape.radius
	target_reached = false
	destination = owner.translation
	
func move(delta):
	
	if not is_instance_valid(target):
		return
		
	if not target_reached:
		
		var direction = destination - owner.translation 
		owner.translation += direction.normalized()*owner.speed*delta
	
	if owner.translation.distance_to(destination) < min_dist:
		
		target_reached = true
		
	if target_reached:
		
		calculate_destination()
		

func calculate_destination():
	
	var rng = RandomNumberGenerator.new()
	var offset_x = rng.randf_range(-radius, radius)
	var offset_z = rng.randf_range(-radius, radius)
	
	var offset = Vector3(offset_x, 0, offset_z)
	
	destination = target.translation + offset
	target_reached = false
	
	
	



