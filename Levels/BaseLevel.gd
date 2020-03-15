extends Spatial

var Healer = preload("res://Character/Healer/Healer.tscn")
var Warrior = preload("res://Character/Warrior/Warrior.tscn")
onready var camera = get_node("Camera")

var selected

onready var army = $PlayerArmy.army


func set_selected(label):
	
	print(label)
	selected = label

func on_SummonButton_released(type):
	
	print("signal")
	army[type] -= 1
	army[type] = max(army[type], 0)
	$UI.load_buttons()
