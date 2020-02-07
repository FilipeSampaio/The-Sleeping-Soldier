extends KinematicBody2D

var bullet = load("res://scenes/bullet.tscn")

onready var enemie_pos_back  = get_parent().get_parent().get_node("enemies_back/Position2D")
onready var enemie_pos_front  = get_parent().get_parent().get_node("enemies_front/Position2D2")

export (float,0,1) var tamanho

var place : String

enum{
	IDLE,
	NEW_DIRECTION,
	MOVE
}

var variation_number = rand_range(2,20)

var target_pos

var state := IDLE

onready var shooter : KinematicBody2D = (get_node("/root/level_test/shooter") as KinematicBody2D)

var speed : int = 300
var direction : int
var velocity : Vector2 = Vector2.ZERO

func _ready():
	randomize()
	$state_time.start(0)
	$shooting_time.start(0)

func _physics_process(delta):
	print(direction)
	scale.x = tamanho
	scale.y = tamanho
	move_start(delta)
	
	if not Engine.editor_hint:
		velocity = move_and_slide(velocity)
		var dir = shooter.global_position - global_position
		if dir.length() > 5:
			$dir_node.rotation = dir.angle()

func move_start(delta):
	if get_parent() is PathFollow2D and ceil(get_parent().position.x) != target_pos:
		get_parent().set_offset(get_parent().get_offset() + variation_number * direction * delta)

func fire_bullet():
	if not Engine.editor_hint:
		var bullet_project = bullet.instance()
		bullet_project.start_pos($dir_node.global_position,$dir_node.rotation)
		get_tree().get_root().get_child(0).add_child(bullet_project)
		$shooting_time.wait_time = rand_range(1,2.5)

func _on_shooting_time_timeout():
	fire_bullet()

func _on_time_variation_timeout():
	variation_number = rand_range(1,8)
	$time_variation.wait_time = rand_range(0,2)
