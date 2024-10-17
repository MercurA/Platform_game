extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = 400.0

@onready var animated_sprite = $AnimatedSprite2D
var default_animations = State.default_animations
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	State.set_animations(str(State.default_char_texture.id))
	
	animated_sprite.play(default_animations.idle)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(JUMP_VELOCITY)
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	handle_animation_states(direction)

	move_and_slide()


func jump(force: int) -> void:
	velocity.y = -force

func death() -> void:
	pass

func handle_animation_states(direction: float) -> void:
	if  Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite.play(default_animations.jump)
	elif not is_on_floor():
		animated_sprite.play(default_animations.fall)
		
	if direction:
		animated_sprite.play(default_animations.run)
	elif is_on_floor():
		animated_sprite.play(default_animations.idle)
		
	if direction == 1:
		animated_sprite.flip_h = false
	elif direction == -1:
		animated_sprite.flip_h = true
