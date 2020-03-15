extends Node

var target
var has_target
var target_reached = false
var movement = get_parent().find_node("Movement")
onready var basic_damage = get_node("Abilities/BasicDamage")

func _process(delta):
			
	if not has_target:
		
		target = choose_target()
		if is_instance_valid(target):
			 has_target = true
			
	if is_instance_valid(target) and has_target and not target_reached:
		
		if basic_damage.is_in_range(target):
			
			target_reached = true
			movement.stop_course()
			
		if not target_reached:
			
			movement.go_to_target(target)
	
	if is_instance_valid(target) and has_target:
		
		#choose what to cast
		if basic_damage.can_shoot(target):
			
			basic_damage.shoot(target)
		
	elif not is_instance_valid(target):
		
		has_target = false

func sort_max_health(var enemy1, var enemy2):
	
	return enemy1.health > enemy2.health
	
func choose_target():
	
	var enemies = get_parent().enemies
	
	if enemies.size() == 0:
		return 
	
	enemies.sort_custom(self, "sort_max_health")
	
	return get_parent().enemies[0]
	
