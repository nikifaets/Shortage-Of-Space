extends Node

export var heal_dmg = 30
var caster

func can_heal(target):
	
	return $Buffer.is_in_range(target)

func get_potential_heal(target):
	
	return min(target.max_health - target.health, heal_dmg)

func set_caster(caster):
	
	
	self.caster = caster
	$Buffer.caster = caster
	$Buffer.team_filter = caster.team
