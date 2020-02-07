extends KinematicBody2D
tool

export (float,0,1) var tamanho

var velocity := Vector2.ZERO

var speed = 80

func _ready():
	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func start_pos(pos,dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed,0).rotated(rotation)
	$time_life.start(0)
	
	
func _on_time_life_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body is player:
		body.queue_free()
		get_tree().paused = true
		yield(get_tree().create_timer(2),"timeout")
		get_tree().paused = false
		get_tree().reload_current_scene()
