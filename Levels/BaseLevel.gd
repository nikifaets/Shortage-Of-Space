extends Spatial

var Giotto = preload("res://Character/Healer/Giotto/Giotto.tscn")
var Leshy = preload("res://Character/Warrior/Leshy/Leshy.tscn")
var Wendigo = preload("res://Character/Warrior/Wendigo/Wendigo.tscn")
var Shanshen = preload("res://Character/Tank/Shanshen/Shanshen.tscn")
var BackButton = preload("res://Interface/Components/MenuButtons/BackButton.tscn")

var labels = {"Leshy" : Leshy, "Giotto" : Giotto, "Wendigo" : Wendigo, "Shanshen" : Shanshen}

onready var camera = get_node("Camera")

var ground_margin = 5
var enemies = []
var allies = []
var selected = labels.keys()[0]

onready var army = $PlayerArmy.army

func _ready():
	
	load_enemies()
	
func _process(delta):
	
	handle_input()
	
	if enemies.size() == 0 or allies.size() == 0:
		
		var back_button = BackButton.instance()
		$UI.add_child(back_button)

func set_selected(label):
	
	selected = label

func load_enemies():
	
	var enemy_nodes = find_node("Enemies").get_children()
	
	for enemy in enemy_nodes:
		
		enemy.set_team(1)
		enemy.connect("die", self, "on_unit_died", [enemy])
		enemies.push_back(enemy)
		
	for enemy in enemy_nodes:
		
		enemy.refresh_allies(enemies)
		enemy.refresh_enemies(allies)

func summon(type):

	var new_ship = labels[selected].instance()
	allies.push_back(new_ship)
	new_ship.set_team(0)
	new_ship.refresh_enemies(enemies)
	new_ship.translation = $"3DCursor".get_cursor_coords()
	add_child(new_ship)
	new_ship.connect("die", self, "on_unit_died", [new_ship])
	
	for enemy in enemies:
		
		enemy.refresh_enemies(allies)
	
	for ally in allies:
		
		ally.refresh_allies(allies)
		
	army[type] -= 1
	army[type] = max(army[type], 0)
	$UI.update_buttons()
	

func handle_input():
	
	if Input.is_action_just_released("summon"):
		
		if $UI.is_unused() and army[selected] > 0:
			summon(selected)
			
func on_unit_died(unit):
	
	print("die")
	enemies.erase(unit)
	allies.erase(unit)
	for enemy in enemies:
		enemy.refresh_enemies(allies)
		enemy.refresh_allies(enemies)
	for ally in allies:
		ally.refresh_allies(allies)
		ally.refresh_enemies(enemies)
	
	unit.queue_free()
