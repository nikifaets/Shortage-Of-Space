extends Spatial

var target
var has_target = false
var caster
var missile
var min_dist = 5
export var speed = 1

func _ready():
	
	find_missile()
	
func _physics_process(delta):
	
	
	if has_target and is_instance_valid(target) and is_instance_valid(caster):
		
		missile.look_at(target.translation, Vector3(0,1,0))
		move(delta)
		
		#print(translation.distance_to(target.translation))
		if translation.distance_to(target.translation) < min_dist:
			
			target.take_damage(caster.dmg)
			
			queue_free()
			
	if not is_instance_valid(target) or not is_instance_valid(caster):
		queue_free()
			
	
func move(delta):
	
	var direction = target.translation - self.translation

	translation += direction.normalized()*speed*delta
	
func shoot(caster, target):
	
	self.target = target
	has_target = true
	self.caster = caster
	
func find_missile():
	
	self.missile = find_node("Missile")
