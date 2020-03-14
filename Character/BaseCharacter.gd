extends Spatial

export var speed = 5
export var health = 20
export var team = 0

var target
var target_available = false
var enemies = []
var allies = []

func _process(delta):
	
	if not target_available:
		
		choose_target()
		

func choose_target():
	
	if enemies.empty():
		
		return 
	
	target_available = true
	target = enemies[0]
	print(self, "team ", team, "chose target", target, " team", target.team)
	
func set_team(var team):
	
	self.team = team

func get_team(var team):
	
	self.team = team
	
func set_target(var target):
	
	self.target = target
	
func get_target():
	
	return self.target
	
func refresh_enemies(var enemies):
	
	self.enemies = enemies
	
func refresh_allies(allies):
	
	self.allies = allies
	

