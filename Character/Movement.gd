extends Node

var up = Vector3(0,1,0)
onready var states = {"Maneuever" : $Maneuever, "Chase" : $Chase}
onready var curr_state = states["Chase"]
var target

func _physics_process(delta):
	
	if not is_instance_valid(target):
		return
		
	curr_state.move(delta)
	owner.look_at(target.translation, up)
	
func change_state(new_state):
	
	if curr_state == states[new_state]:
		return
		
	curr_state.exit_state()
	curr_state = states[new_state]
	curr_state.enter_state()

func go_to_target(target):
	
	self.target = target
	change_state("Chase")

func maneuever(target):
	
	self.target = target
	change_state("Maneuever")
	

	
	
