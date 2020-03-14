extends Node

onready var base_heal = get_node("Abilities/BasicHeal")

var base_range = 10
var movement = get_parent().find_node("Movement")
var at_target = false
var has_target = false
var target 

func _process(delta):
	
	#choose action - base heal or mass heal
	if not has_target:
		
		var base_heal_potential = 0
		var mass_heal_potential = 0
		
		target = choose_target()
		if is_instance_valid(target):
			
			if target.health >= target.max_health:
				
				if target.translation.distance_to(owner.translation) > 10:
					movement.go_to_target(target)

				return
				
			base_heal_potential = base_heal.get_potential_heal(target)
			
			if base_heal_potential > mass_heal_potential:
				
				has_target = true
		
	if is_instance_valid(target) and has_target:
		
		print("has target")
		if base_heal.can_heal(target):
			
			movement.stop_course()
			target.health += 20
			if target.health > 100:
				target.health = 100
			has_target = false
			
		else:
				
			movement.go_to_target(target)

func comp_health(var ally1, var ally2):
	
	return ally1.health < ally2.health
	
func choose_target():
	
	if get_parent().allies.size() == 0:
		
		return
		
	get_parent().allies.sort_custom(self, "comp_health")
	
	#search for a tank if all are full health
	var first_wounded = get_parent().allies[0]
	
	if first_wounded.health == first_wounded.max_health:
		for ally in get_parent().allies:
			
			if ally.role == "Tank":
				
				return ally
			
	# if tank not found

	return get_parent().allies[0]
	
