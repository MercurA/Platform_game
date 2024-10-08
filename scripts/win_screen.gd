extends Control
@onready var button = $Button

func _ready():
	State.high_score.sort_custom(sort_descending)
	var name_label_y_pos = 150
	for score in State.high_score:
		name_label_y_pos += 30
		create_label(score.name, score.points, name_label_y_pos)


func create_label(name, points, name_label_y_pos ):
	var name_label = Label.new()
	var points_label = Label.new()
	name_label.position = Vector2(450, name_label_y_pos)
	points_label.position = Vector2(680, name_label_y_pos)
	name_label.text = name
	points_label.text = str(points)
	add_child(name_label)
	add_child(points_label)

func sort_ascending(a, b) -> bool:
	if a.points < b.points:
		return true
	return false
	
func sort_descending(a, b) -> bool:
	if a.points > b.points:
		return true
	return false

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
