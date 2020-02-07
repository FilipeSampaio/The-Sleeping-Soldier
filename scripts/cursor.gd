extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	position = get_global_mouse_position()
	if Input.get_action_strength("mouse_left"):
		$Sprite.modulate = Color(42,32,5)
	else:
		$Sprite.modulate = Color(1,1,1)
