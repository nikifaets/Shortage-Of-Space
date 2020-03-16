extends Spatial

onready var Missile = find_node("Missile").missile

var caster
var cd_ready = true
export var dmg = 10
export var area = 10
var can_shoot 

	
func can_shoot(var target):
	
	return cd_ready and is_in_range(target)
	
func is_in_range(var target):
	
	return $Buffer.targets.has(target)

func set_caster(caster):
	
	self.caster = caster
	$Buffer.caster = caster
	if caster.team == 1:
		$Buffer.team_filter = 0
	else:
		$Buffer.team_filter = 1
	
func shoot(target):
	
	if can_shoot(target):
		
		can_shoot = true
		var missile = Missile.instance()
		get_tree().get_root().add_child(missile)
		missile.translation = to_global(translation)
		missile.look_at(target.translation, Vector3(0,1,0))
	
		missile.shoot(self, target)
		$Cooldown.start()
		cd_ready = false

func on_target_reached(target):
	
	if is_instance_valid(target):
		target.take_damage(dmg)
		
func _on_Cooldown_timeout():
	
	cd_ready = true
