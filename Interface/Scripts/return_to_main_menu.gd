extends Control

func _on_BackButton_pressed():
	print("Hello?")
	get_tree().change_scene("res://Interface/TitleScreen.tscn")
