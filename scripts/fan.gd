extends Area2D

signal fan_activated

func _on_body_entered(body):
	if body is Player:
		fan_activated.emit()
