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
signal die

func set_team(var team):
	
	self.team = team
	var abilities = $Behavior/Abilities.get_children()
	for ab in abilities:
		
		ab.set_caster(self)

func set_target(var target):
	
	self.target = target
	
func get_target():
	
	return self.target
	
func refresh_enemies(var enemies):
	
	self.enemies = enemies
	
func refresh_allies(allies):
	
	self.allies = allies
	
func take_damage(dmg):
	
	health -= dmg
	
	if health <= 0:
		
		emit_signal("die")

func heal(dmg):
	
	health += dmg
	if health > max_health:
		health = max_health
	

