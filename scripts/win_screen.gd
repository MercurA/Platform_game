extends Control

func _ready():
	State.high_score.sort_custom(sort_descending)
	var name_label_y_pos = 150
	for score in State.high_score:
		name_label_y_pos += 30
		create_label(score.name, score.points, name_label_y_pos)


func create_label(score_name, points, name_label_y_pos ):
	var name_label = Label.new()
	var points_label = Label.new()
	name_label.position = Vector2(450, name_label_y_pos)
	points_label.position = Vector2(680, name_label_y_pos)
	name_label.text = score_name
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

func _on_start_over_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/start_game.tscn")


func _on_try_again_pressed():
	State.lifes = 3
	State.points = 0
	var path = "res://scenes/Levels/" + State.current_level + '.tscn'
	get_tree().change_scene_to_file(path)
