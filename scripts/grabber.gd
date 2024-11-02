extends Node2D
@onready var path_follow = $Path2D/PathFollow2D

signal touched_wall(path: PathFollow2D)
signal detached(path: PathFollow2D)
func _on_detect_body_entered(body):
	if body is Player:
		touched_wall.emit(path_follow)


func _on_detect_body_exited(body):
	if body is Player:
		detached.emit(path_follow)
