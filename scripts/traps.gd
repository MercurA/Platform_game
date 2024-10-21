extends Area2D

signal touched
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var timer = $Timer

@export var fire_on: bool = true
@export var wait_time: float = 2.0

func _ready():
	timer.wait_time = wait_time
	if fire_on:
		animated_sprite.play("fire_on")

func _process(_delta):
	if not fire_on:
		animated_sprite.play("fire_off")
		collision_shape.disabled = true
	if fire_on:
		animated_sprite.play("fire_on")
		collision_shape.disabled = false

func _on_body_entered(_body):
	touched.emit()

func set_fire_state(state):
	fire_on = state

func _on_detection_body_entered(body):
	if body is Player:
		fire_on = true

func _on_timer_timeout():
	fire_on = !fire_on
