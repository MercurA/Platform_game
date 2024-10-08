extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var jump_force = 700

func _on_body_entered(body):
	if body is Player:
		body.jump(jump_force)
		animated_sprite.play()
