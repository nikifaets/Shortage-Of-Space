extends Spatial

onready var basic_damage = $Abilities.find_node("BasicDamage")
onready var movement = owner.find_node("Movement")
var target

func _ready():
	
	var radius = $Abilities/BasicDamage.find_node("CollisionShape").shape.radius
	movement.set_radius(radius)
	
var has_target = false

func _process(delta):
	
	if not has_target:
		target = choose_target_random()
	
	if not is_instance_valid(target):
		has_target = false
		return
		
	else:
		has_target = true
	
	if has_target:
			
		if basic_damage.is_in_range(target):
			
			movement.maneuever(target)
				
		else:
			
			movement.go_to_target(target)
			
		
		if basic_damage.can_shoot(target):
		
			$Abilities/BasicDamage.shoot(target)
			$Abilities/BasicDamage2.shoot(target)
		
		
func choose_target_random():
	
	var buffer = $Abilities/BasicDamage/Buffer
	buffer.remove_dead()
	
	var ships_in_range = buffer.targets.size()
	
	if ships_in_range == 0:
		return
		
	randomize()
	var chosen = randi() % ships_in_range
	
	return buffer.targets[chosen]
