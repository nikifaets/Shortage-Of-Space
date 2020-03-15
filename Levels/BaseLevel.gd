extends Spatial

var Healer = preload("res://Character/Healer/Healer.tscn")
var Warrior = preload("res://Character/Warrior/Warrior.tscn")

var labels = {"Healer" : Healer, "Warrior" : Warrior}

onready var camera = get_node("Camera")

var selected

onready var army = $PlayerArmy.army

func _process(delta):
	
	handle_input()

func set_selected(label):
	
	print(label)
	selected = label

func summon(type):
	
	print("summon selected ", selected)
	army[type] -= 1
	army[type] = max(army[type], 0)
	print("load buttons again")
	$UI.update_buttons()
	
	var new_ship = labels[selected].instance()
	new_ship.set_team(0)
	new_ship.translation = $"3DCursor".get_cursor_coords()
	add_child(new_ship)
	
	
func handle_input():
	
	if Input.is_action_just_released("summon"):
		
		if $UI.is_unused():
			summon(selected)
