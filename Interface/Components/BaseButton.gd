extends Button

export (String) var scene_to_load


func _on_QuitButton_pressed():
	get_tree().quit()
