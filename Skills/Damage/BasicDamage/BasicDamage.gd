extends Spatial

var caster

func can_hit(var target):
	
	return $Buffer.targets.has(target)

func set_caster(caster):
	
	self.caster = caster
	$Buffer.caster = caster
	if caster.team == 1:
		$Buffer.team_filter = 0
	else:
		$Buffer.team_filter = 1
	
