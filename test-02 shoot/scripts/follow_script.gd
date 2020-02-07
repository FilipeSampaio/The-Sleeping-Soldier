extends Node2D

var goal := Vector2.ZERO
var start_pos := Vector2.ZERO

func _physics_process(delta):
	var direction = (goal - global_position)
	var distance = sqrt(pow(direction.x,2)+pow(direction.y,2))
	direction = direction/distance
	var new_direction = global_position + direction * 5
	global_position = new_direction
