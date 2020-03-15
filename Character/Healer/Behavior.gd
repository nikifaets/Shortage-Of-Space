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
				
				if not base_heal.can_heal(target):
					movement.go_to_target(target)
				
				else:
					
					movement.stop_course()
					
				return
				
			base_heal_potential = base_heal.get_potential_heal(target)
			
			if base_heal_potential > mass_heal_potential:
				
				has_target = true
		
	if is_instance_valid(target) and has_target:
		
		if base_heal.can_heal(target) and target.health < target.max_health:
			
			movement.stop_course()
			target.health += 20
			if target.health > 100:
				target.health = 100
			has_target = false
			
		else:
				
			movement.go_to_target(target)

func calculate_priority_score(target, health_score, dist_score):
	
	var dist = owner.translation.distance_to(target.translation)
	var heal = target.max_health - target.health
	
	#lower dist = higher score
	return  health_score * heal - dist * dist_score
	
func comp_health(var ally1, var ally2):
	
	var eps = 1e-2
	var health_score = 0.7
	var dist_score = 0.3
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
	
