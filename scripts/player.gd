extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = 400.0
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite.play('Idle')

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
		animated_sprite.play("Jump")
	elif not is_on_floor():
		animated_sprite.play("Fall")
		
	if direction:
		animated_sprite.play("Run")
	elif is_on_floor():
		animated_sprite.play("Idle")
		
	if direction == 1:
		animated_sprite.flip_h = false
	elif direction == -1:
		animated_sprite.flip_h = true
