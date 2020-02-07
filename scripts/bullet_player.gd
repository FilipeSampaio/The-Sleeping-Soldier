extends KinematicBody2D

export (float,0,1) var tamanho

var velocity := Vector2.ZERO

var speed = 80

func _ready():
	$time_life.start(0)

func _on_time_life_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	body.get_parent().queue_free()
	queue_free()



