extends Node

var pos : Vector2
var global_pos : Vector2
var current_state : int

func current_info(info):
	match info:
		"pos":
			return pos
		"global_pos":
			return global_pos
		"current_state":
			return current_state
