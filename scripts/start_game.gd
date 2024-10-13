extends Control

func _on_button_pressed():
	State.lifes = 3
	State.points = 0
	get_tree().change_scene_to_file("res://scenes/UI/character_selection.tscn")
