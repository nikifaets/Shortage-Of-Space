extends Camera

var speed = 1

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
