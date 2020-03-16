extends "MovementState.gd"

func move(delta):
	
	var target = get_parent().target
		
	var direction = target.translation - owner.translation
	owner.translation += direction.normalized()*delta*owner.speed 

