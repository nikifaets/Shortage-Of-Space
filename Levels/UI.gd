extends Control


var buttons = []
var color_selected = Color(0.5, 0.5, 0.5, 1)
var color_normal = Color(0.6, 0.6, 0.6, 1)
var selected

func _ready():
	
	call_deferred("load_buttons")

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
	#button.expand_icon = true
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
	
