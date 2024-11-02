extends CharacterBody2D
class_name Player
enum STATE {IDLE, RUN, JUMP, FALL, GLIDE, CRAWL, ATTACK, PICKUP, HIDE, EAT, CLIMB}
var state : STATE
const SPEED = 300.0
const JUMP_VELOCITY = 400.0
@onready var glide_timer = $glide_timer
@onready var animated_sprite = $AnimatedSprite2D 
var default_animations = State.default_animations
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_gravity = 800
var glide_gravity = 200
var gravity = base_gravity
var is_on_wall = false
var climb_path : PathFollow2D = null
var climb_speed = 100  # Adjust this to control climbing speed
# Counters
var counter = 0
var glide_counter = 0

func _ready():
	connect_groups()
	State.set_animations(str(State.default_char_texture.id))

func _physics_process(delta):
	print(gravity)
	var initiating_jump := (is_on_floor() or is_on_wall) and Input.is_action_just_pressed("jump")
	var direction_h = Input.get_axis("move_left", "move_right")
	
	velocity.y += gravity * delta
	if direction_h == 1:
		animated_sprite.flip_h = false
	elif direction_h == -1:
		animated_sprite.flip_h = true

	if direction_h:
		velocity.x = direction_h * SPEED
	else:
		set_state(STATE.IDLE)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if initiating_jump:
		set_state(STATE.JUMP)
	elif state == STATE.JUMP and velocity.y > 0.0:
		set_state(STATE.FALL)
	elif state in [ STATE.JUMP, STATE.FALL ] and Input.is_action_just_pressed("glide"):
		glide_counter += 1
		set_state(STATE.GLIDE)
		print(gravity)
	elif direction_h and is_on_floor():
		set_state(STATE.RUN)
	elif is_on_wall:
		set_state(STATE.CLIMB, delta)
	elif not is_on_wall:
		set_state(STATE.FALL)
	elif state == STATE.CLIMB and Input.is_action_just_pressed("jump"):
		set_state(STATE.JUMP)
	
	if is_on_floor():
		glide_counter = 0
		gravity = base_gravity
		
	move_and_slide()
	
func choose_direction_axis():
	var direction_h = Input.get_axis("move_left", "move_right")
	var direction_v = Input.get_axis("down", "up")
	
	if direction_h:
		return direction_h
	else:
		return direction_v
	
func set_state(new_state: int, delta = null,) -> void:
	var previous_state := state
	state = new_state
	
	# You can check both the previous and the new state to determine what to do when the state changes. This checks the previous state.
	if previous_state == STATE.GLIDE and glide_counter == 2:
		gravity = base_gravity
		glide_counter = 0

	# Here, I check the new state.
	if state == STATE.GLIDE:
		gravity = glide_gravity
	elif state == STATE.IDLE:
		animated_sprite.play(default_animations.idle)
	elif state == STATE.RUN:
		animated_sprite.play(default_animations.run)
	elif state == STATE.JUMP:
		velocity.y = -JUMP_VELOCITY
		choose_direction_axis()
		animated_sprite.play(default_animations.jump)
	elif state == STATE.CLIMB:
		if climb_path is PathFollow2D:
			climb_path.progress_ratio += (choose_direction_axis() * climb_speed * delta) / 100
			global_position = climb_path.global_position

func _on_touched_wall(path: PathFollow2D) -> void:
	climb_path = path
	is_on_wall = true
	
func _on_detached_wall(path: PathFollow2D) -> void:
	climb_path = path
	climb_path.progress_ratio = 0
	is_on_wall = false


func connect_groups():
	var grabbers = get_tree().get_nodes_in_group('grabbers')
	
	for grabber in grabbers:
		grabber.touched_wall.connect(_on_touched_wall)
		grabber.detached.connect(_on_detached_wall)	
