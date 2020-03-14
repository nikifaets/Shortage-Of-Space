extends Node

var target
var has_target
var movement = get_parent().find_node("Movement")
func _process(delta):
	
	if not has_target:
		
		target = choose_target()
	
	if is_instance_valid(target):
		
		movement.go_to_target(target)
		
	
func sort_max_health(var enemy1, var enemy2):
	
	return enemy1.health > enemy2.health
	
func choose_target():
	
	get_parent().enemies.sort_custom(self, "sort_max_health")
	
	return get_parent().enemies[0]
	
