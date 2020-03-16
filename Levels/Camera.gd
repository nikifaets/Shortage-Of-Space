extends Camera

var speed = 1
var movement_steps = 10
var scrolls = 0
var scroll_step
var rotation_step = 0.1
var margin = 25

func _ready():
	
	scroll_step = (translation.y - margin) / movement_steps 
	
func _process(delta):
	
	handle_input()
	
func handle_input():
	
	if Input.is_action_pressed("move_up"):

		translation += Vector3(0, 0, -speed)
	
	if Input.is_action_pressed("move_down"):
		
		translation += Vector3(0, 0, speed)
		
	if Input.is_action_pressed("move_right"):
		
		translation += Vector3(speed, 0, 0)
	
	if Input.is_action_pressed("move_left"):
		
		translation += Vector3(-speed, 0, 0)
		
	if Input.is_action_pressed("zoom_in"):
		print("zoom in")
		
	if Input.is_action_pressed("zoom_out"):
		
		print("zoom out")
		
func _input(event):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP :
			move_down()
			
		if event.button_index == BUTTON_WHEEL_DOWN:
			move_up()
			
func move_down():
	
	scrolls += 1
	
	if scrolls > movement_steps:
		scrolls = movement_steps
		return
		
	translation.y -= scroll_step
	var rotation_axis = get_transform().basis[0]
	rotate(rotation_axis, rotation_step)
	
func move_up():
	
	scrolls -= 1
	
	if scrolls < 0:
		scrolls = 0
		return
		
	translation.y += scroll_step
	var rotation_axis = get_transform().basis[0]
	rotate(rotation_axis, -rotation_step)
	

	
