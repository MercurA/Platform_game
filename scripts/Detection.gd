extends Area2D

signal player_detected(detector_type)
signal trap_detect(trap_type)
@export var detector_type = ''

func _on_body_entered(body):
	if body is Player:
		player_detected.emit(detector_type)


func _on_area_entered(area):
	if area.trap_type:
		trap_detect.emit(area.trap_type)
