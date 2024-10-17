extends Node
class_name GameState

var points: int = 0
var lifes: int = 3
var default_char_texture =  {
	"id": 3,
	"path": 'res://assets/Main Characters/Mask Dude/Jump (32x32).png'
}
var default_animations = {
	"jump": 'Jump_3',
	"run": 'Run_3',
	"idle": 'Idle_3',
	"fall": 'Fall_3'
}
var high_score = [
	{
		"points": 14,
		"name": 'aa'
	},
	{
		"points": 12,
		"name": 'gg'
	},
	{
		"points": 9,
		"name": 'gg'
	},
	{
		"points": 100,
		"name": 'gg'
	},
]

func addPoints(amount: int) -> void:
	points += amount
	
func getPoints() -> int:
	return points
	
func substractPoints(amount: int) -> void:
	points -= amount

func get_life() -> int:
	return lifes

func substract_life(amount) -> void:
	lifes -= amount

func add_life(amount) -> void:
	lifes += amount

func set_animations(id: String) -> void:
	default_animations.jump = "Jump_" + id
	default_animations.idle = "Idle_" + id
	default_animations.fall = "Fall_" + id
	default_animations.run = "Run_" + id
