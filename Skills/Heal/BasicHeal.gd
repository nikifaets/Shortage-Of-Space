extends Node

export var heal_dmg = 15
var caster
var cd_ready = true

export var area = 10
	
func can_heal(target):
	
	return is_in_range(target) and cd_ready

func is_in_range(target):
	
	return $Buffer.targets.has(target)

func cast(target):
	
	target.heal(heal_dmg)
	cd_ready = false
	$Cooldown.start()
	
func get_potential_heal(target):
	
	return min(target.max_health - target.health, heal_dmg)

func set_caster(caster):
	
	
	self.caster = caster
	$Buffer.caster = caster
	$Buffer.team_filter = caster.team


func _on_Cooldown_timeout():
	
	cd_ready = true
