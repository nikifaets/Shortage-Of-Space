extends Control

onready var TitleScreen = preload("res://Interface/TitleScreen.tscn")
onready var FleetScreen = preload("res://Interface/Scenes/FleetScreen.tscn")
onready var LobbySound = preload("res://Sounds/Scenes/MainMenu.tscn")
onready var FightSound = preload("res://Sounds/Scenes/Fight.tscn")

var curr_scene
var curr_sound

func _ready():
	
	curr_scene = TitleScreen.instance()

	curr_sound = LobbySound.instance()
	add_child(curr_sound)
	curr_sound.play()
	add_child(curr_scene)

func change_scene(scene):
	
	var new_scene = scene.instance()
	self.curr_scene.queue_free()
	self.curr_scene = new_scene

	play_sound(curr_scene)
	add_child(self.curr_scene)
	
func play_sound(scene):
	
	if not is_instance_valid(curr_sound):	
		
		return
	
	var new_sound
	if scene.filename.find("Level") != -1:
		
		print("did not find")
		new_sound = FightSound.instance()
	
	else:
		
		new_sound = LobbySound.instance()
	
	if new_sound.filename == curr_sound.filename:
		return
		
	curr_sound.queue_free()
	curr_sound = new_sound
	add_child(curr_sound)
	curr_sound.play()
	
		
	
