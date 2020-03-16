extends Control

var scene_to_load

func _ready():
	$Menu/BoxContainer/Controls/PlayButton.grab_focus()
	for button in $Menu/BoxContainer/Controls.get_children():
		button.connect("pressed", self, "_on_pressed", [button.scene_to_load])

func _on_pressed(_scene_path):
	scene_to_load = _scene_path
	print("Changing scene to " + scene_to_load)
	$FadeIn.show()
	$FadeIn.fade_in()

# Actually change the scene once the transition is finished.
func _on_FadeIn_fade_finished():
	
	var scene = load(scene_to_load)
	get_parent().change_scene(scene)
