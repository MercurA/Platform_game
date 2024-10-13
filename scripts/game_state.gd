extends Node
class_name GameState

var points: int = 0
var lifes: int = 3

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
