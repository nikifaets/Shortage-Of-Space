extends Node

export var heal_dmg = 30

func can_heal(var target):
	
	return $Buffer.is_in_range(target)

func get_potential_heal(var target):
	
	return min(target.max_health - target.health, heal_dmg)
