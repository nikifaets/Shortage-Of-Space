extends Spatial

var teams = []

func _ready():
	
	assign_teams()
	load_units_list()

func assign_teams():
	
	var team_node = find_node("Teams")
	var teams_nodes = team_node.get_children()
	
	var team_count = teams_nodes.size()
	for i in range(team_count):
		
		
		var next_team = team_node.find_node("Team"+str(i))
		var characters = next_team.get_children()
		teams.push_back(characters)
		for character in characters:
				
			character.set_team(i)
				
func load_units_list():
	
	for i in range(teams.size()):
		
		for character in teams[i]:
			
			var char_allies = []
			var char_enemies = []
			for j in range(teams.size()):
				
				for next_char in teams[j]:
					
					if character == next_char:
						
						continue
					
					if i ==j:
						
						char_allies.push_back(next_char)
						
					else:
						
						char_enemies.push_back(next_char)
						
			character.refresh_allies(char_allies)
			character.refresh_enemies(char_enemies)
			
	
