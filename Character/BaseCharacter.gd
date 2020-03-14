extends Spatial

export var speed = 5
export var max_health = 100
export var health = 100
var role
var team = 0
var target
var target_available = false
var enemies = []
var allies = []
	
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
	

