extends Area

var targets = []
var team_filter = 0

func set_team_filter(var team_filter):
	
	self.team_filter = team_filter


func _on_Buffer_body_entered(character):
	
	if(character.team == team_filter):
		
		targets.push_back(character)


func _on_Buffer_body_exited(character):
	
	if(character.team == team_filter):
		
		targets.erase(character)
		
func is_in_range(character):
	
	return targets.has(character)
