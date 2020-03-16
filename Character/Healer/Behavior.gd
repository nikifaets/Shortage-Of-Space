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
		
		target = choose_target()
		
		if is_instance_valid(target):
			
			var potential_basic_heal = $Abilities/BasicHeal.get_potential_heal(target)
			var potential_mass_heal = 0
			
			var potential_heal = max(potential_basic_heal, potential_mass_heal)
			var chosen_ability
			
			if potential_heal == 0:
				
				if base_heal.is_in_range(target):
					return
				#there is noone to heal, just move towards a target
				movement.go_to_target(target)
				return
				
			if potential_basic_heal > potential_mass_heal:
				
				has_target = true
	
	elif has_target and is_instance_valid(target):
		
		if base_heal.can_heal(target):
			
			base_heal.cast(target)
			has_target = false
			
		elif not base_heal.is_in_range(target):
			
			movement.go_to_target(target)
			
	elif not is_instance_valid(target):
		
		has_target = false
				
func calculate_priority_score(target, health_score, dist_score):
	
	var dist = owner.translation.distance_to(target.translation)
	var heal = target.max_health - target.health
	
	#lower dist = higher score
	return  health_score * heal - dist * dist_score
	
func comp_health(var ally1, var ally2):
	
	var eps = 1e-2
	var health_score = 0.5
	var dist_score = 0.5
	var dist1 = owner.translation.distance_to(ally1.translation) + eps
	var heal1 = ally1.max_health - ally1.health
	
	var dist2 = owner.translation.distance_to(ally2.translation) + eps
	var heal2 = ally2.max_health - ally2.health
	
	if heal1 == 0 and heal2 == 0:
		
		return dist1 > dist2
		
	dist1 = dist1 / max(dist1, dist2)
	heal1 = heal1 / max(heal1, heal2)
	dist2 = dist2 / max(dist1, dist2)
	heal2 = heal2 / max(heal1, heal2)
	
	var score1 = health_score * heal1 - dist_score * dist1
	var score2 = health_score * heal2 - dist_score * dist2

	return score1 > score2
	
func choose_target():
	
	if owner.allies.size() == 0:
		
		return
		
	owner.allies.sort_custom(self, "comp_health")
	
	#search for a tank if all are full health
	var first_wounded = owner.allies[0]
	
	if first_wounded.health == first_wounded.max_health:
		for ally in owner.allies:
			
			if ally.role == "Tank":
				
				return ally
				
		if first_wounded == owner and owner.allies.size() > 1:
			
			return owner.allies[1]
			
	# if tank not found and target is not self

	return first_wounded
	
