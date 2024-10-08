extends Control

@onready var life = $Life
@onready var points = $Points
@onready var time = $Time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life.text = str(State.get_life()) + " x "
	points.text = "    : " + str(State.getPoints())


func add_time_left(time_left):
	time.text = "Time: " + str(time_left)
