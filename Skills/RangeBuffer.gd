extends Area

var targets = []
var team_filter = 0
var caster
	
func _on_Buffer_body_entered(character):
	
	if(team_filter == character.team):
		
		targets.push_back(character)


func _on_Buffer_body_exited(character):
	
	if(team_filter == character.team):
		
		targets.erase(character)
		
func is_in_range(character):
	
	return targets.has(character)
