extends Node

var target
var has_target
var target_reached = false
var movement = get_parent().find_node("Movement")
onready var basic_damage = $Abilities/BasicDamage
onready var range_radius = basic_damage.find_node("CollisionShape", true).shape.radius

func _ready():
	
	var radius = basic_damage.find_node("CollisionShape").shape.radius
	movement.set_radius(radius)
	
func _process(delta):
	
	owner.find_node("Movement").target = target
	if not has_target:
		
		target = choose_target()
		
		if is_instance_valid(target):
			
			print(target)
			has_target = true
			
	if has_target and is_instance_valid(target):
		
		if basic_damage.is_in_range(target):
			
			movement.maneuever(target)
			basic_damage.shoot(target)
		
		else:
			
			movement.go_to_target(target)
			
	if not is_instance_valid(target):
		
		has_target = false
		

func sort_max_health(var enemy1, var enemy2):
	
	var health_score = 0.7
	var dist_score = 0.3
	var dist1 = owner.translation.distance_to(enemy1.translation)
	var dist2 = owner.translation.distance_to(enemy2.translation)
	
	if dist1 == dist2:
		return enemy1.health > enemy2.health
		
	if enemy1.health == enemy2.health:
		return dist1 < dist2
		
	dist1 = dist1 / max(dist1, dist2)
	dist2 = dist2 / max(dist1, dist2)
	
	var health1 = enemy1.health / max(enemy1.health, enemy2.health)
	var health2 = enemy2.health / max(enemy1.health, enemy2.health)
	
	var score1 = health_score * health1 - dist_score * dist1
	var score2 = health_score * health2 - dist_score * dist2
	
	return score1 > score2
	
func choose_target():
	
	var enemies = get_parent().enemies
	
	if enemies.size() == 0:
		return 
	
	enemies.sort_custom(self, "sort_max_health")
	
	return get_parent().enemies[0]
	
