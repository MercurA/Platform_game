extends Area2D

@export var value: int = 1
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

signal is_collected(value)

func _ready():
	animated_sprite.play("default")

func _on_body_entered(body):
	if body is Player:
		is_collected.emit(value)
		timer.start()
		animated_sprite.play("collected")

func _on_timer_timeout():
	queue_free()
