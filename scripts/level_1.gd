extends Node2D

var player = null
@onready var start = $Start
@onready var hud = $UILayer/HUD
@export var level_time = 20
@export var level_name = ''

var timer_node = null
var time_left

func _ready():
	State.current_level = level_name
	player = get_tree().get_first_node_in_group('player')
	if player != null:
		player.global_position = start.get_spawn_pos()
	connect_groups()
	create_level_timer()

func _process(_delta):
	if State.get_life() <= 0:
		get_tree().change_scene_to_file('res://scenes/UI/win_screen.tscn')
		State.high_score.append({
			"points": State.getPoints(),
			"name": 'example'
		})
		
func _on_level_timeout():
	time_left -= 1
	hud.add_time_left(time_left)
	if time_left <= 0:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
		time_left = level_time	
	
func _on_touched_player() -> void:
	State.substract_life(1)

func _on_fruit_collected(amount) -> void:
	State.addPoints(amount)

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_pos()

func create_level_timer():
	time_left = level_time
	hud.add_time_left(time_left)
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timeout)
	add_child(timer_node)
	timer_node.start()
	
func connect_groups():
	var traps = get_tree().get_nodes_in_group('traps')
	var collectables = get_tree().get_nodes_in_group("collectables")
	#var detectors =  get_tree().get_nodes_in_group('detectors')
	for trap in traps:
		trap.touched.connect(_on_touched_player)
	for collected in collectables:
		collected.is_collected.connect(_on_fruit_collected)
