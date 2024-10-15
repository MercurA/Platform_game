extends Control
@onready var character = $character
signal load_texture

const sprites = [
	{
		"id": 1,
		"path": 'res://assets/Main Characters/Mask Dude/Jump (32x32).png'
	},
	{
		"id": 2,
		"path": 'res://assets/Main Characters/Ninja Frog/Jump (32x32).png'
	},
	{
		"id": 3,
		"path": 'res://assets/Main Characters/Pink Man/Jump (32x32).png'
	},
	{
		"id": 4,
		"path": 'res://assets/Main Characters/Virtual Guy/Jump (32x32).png'
	},
]

var counter = 0
	
func _on_nav_left_pressed():
	if counter == 0:
		counter = 4
	counter -= 1
	load_texture.emit(sprites[counter])

func _on_nav_right_pressed():
	if counter == 3:
		counter = -1
	counter += 1
	load_texture.emit(sprites[counter])

func _on_start_game_pressed():
	State.lifes = 3
	State.points = 0
	State.default_char_texture =  sprites[counter]
	get_tree().change_scene_to_file("res://scenes/Levels/level_1.tscn")
