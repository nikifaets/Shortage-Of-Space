extends Control

var SummonButton = preload("res://UI/SummonButton/SummonButton.tscn")

var buttons = []

func _ready():
	
	call_deferred("load_buttons")

func load_buttons():
	
	for i in range(owner.army.size()):
		
		var label = owner.army.keys()[i]
		var count = owner.army.values()[i]
		
		var button = SummonButton.instance()
		button.text = label + ": " + str(count)
		buttons.push_back(button)
	
	for button in buttons:
		
		$HBoxContainer.add_child(button)
