extends Control

var HealthBar = preload("HealthBar.tscn")

var buttons = []
var color_selected = Color(0.5, 0.5, 0.5, 1)
var color_normal = Color(0.6, 0.6, 0.6, 1)
var selected
var units = {}

func _ready():
	
	call_deferred("load_buttons")

func _process(delta):
	pass
	update_bars()
	
func is_unused():
	
	for button in buttons:
		
		if button.is_hovered() or button.is_pressed():
			return false
	
	return true

func create_health_bars():
	
	for enemy in owner.enemies():
		load_health_bar(enemy)
		
	for ally in owner.allies:
		load_health_bar(ally)
		
func load_health_bar(unit):
	
	var bar = HealthBar.instance()
	add_child(bar)
	units[unit] = bar
	
func update_bars():
	
	var margin = 60
	#clean dictionary
	for unit in units.keys():
		if not is_instance_valid(unit):
			units[unit].queue_free()
			units.erase(unit)
	
	#add new bars
	for enemy in owner.enemies:
		if not units.has(enemy):
			load_health_bar(enemy)
			
	for ally in owner.allies:
		if not units.has(ally):
			load_health_bar(ally)
			
	for unit in units.keys():
		
		var screen_cords = owner.find_node("Camera").unproject_position(unit.translation)
		var bar_pos = screen_cords + Vector2(0, margin)
		units[unit].rect_position = bar_pos
		units[unit].max_value = unit.max_health
		units[unit].value = unit.health
	
	
	
func update_buttons():
	
	for i in range(owner.army.size()):
		
		var label = owner.army.keys()[i]
		var count = owner.army.values()[i]
		
		buttons[i].text = label + ": " + str(count)
		
func load_buttons():
	
		
	for i in range(owner.army.size()):
		
		var label = owner.army.keys()[i]
		var count = owner.army.values()[i]
		
		var button = design_button(label, count)
		
		button.connect("button_up", self, "on_button_released", [button])

		buttons.push_back(button)
	
	for button in buttons:
		
		$HBoxContainer.add_child(button)
		
func on_button_released(button):
	
	var stylebox_normal = design_stylebox(color_normal)
	if is_instance_valid(selected):
		
		stylebox_add_border(stylebox_normal, 3)
		stylebox_normal.border_blend = true
		selected.add_stylebox_override("normal", stylebox_normal)
		
	
	var stylebox_selected = design_stylebox(color_selected)
	stylebox_add_border(stylebox_selected, 3)
	
	button.add_stylebox_override("normal", stylebox_selected)
	var label = button.text
	label = label.left(label.find(':'))
	
	selected = button
	owner.set_selected(label)
	
func design_button(label, count):
	
	var button = Button.new()
	var texture = ImageTexture.new()
	var path = "res://Icons/" + label + ".png"
	texture.load(path)
	texture.set_size_override(Vector2(50,50))
	
	var stylebox = design_stylebox(color_normal)
	button.add_stylebox_override("normal", stylebox)
	button.set_button_icon(texture)
	button.text = label + ": " + str(count)
		
	return button

func design_stylebox(color):
	
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = color
	stylebox.border_color = Color(0.1, 0.1, 0.7, 1)
	
	return stylebox
	
func stylebox_remove_border(stylebox):
	
	stylebox.border_width_top = 0
	stylebox.border_width_bottom = 0
	stylebox.border_width_right = 0
	stylebox.border_width_left = 0
	
func stylebox_add_border(stylebox, width):
	
	stylebox.border_width_top = width
	stylebox.border_width_bottom = width
	stylebox.border_width_right = width
	stylebox.border_width_left = width
	
