extends Control

func _on_BackButton_pressed():
	
	var lobby = get_tree().get_root().get_children()[0]

	var title_screen = load("res://Interface/TitleScreen.tscn")
	lobby.change_scene(title_screen)
