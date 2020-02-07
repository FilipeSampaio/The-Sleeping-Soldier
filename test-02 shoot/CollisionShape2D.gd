extends CollisionShape2D


func _physics_process(delta):
	get_parent().get_child(Timer)
