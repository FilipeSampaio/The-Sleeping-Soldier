extends Node

onready var enemie_pos_back  = get_parent().get_node("enemies_back/Path2D")
onready var enemie_pos_front  = get_parent().get_node("enemies_front/Path2D")

export (String,"basic enemy","intermediate enemy","hard enemy") var enemie_type
var pre_enemie : PackedScene = preload("res://scenes/Enemy.tscn")
var enemies_number = 0

onready var tween = $Tween

export (int) var limit

var big_enemie = 0.4
var small_enemie = 0.2
var viewport

func _ready():
	randomize()
	$Timer.start()

func add_enemy():
	print(enemies_number)
	var select_local = randi()%2+0
	if get_tree().get_nodes_in_group("enemies").size() <= limit:
		match select_local:
			1:
				var pathfollow = PathFollow2D.new()
				var enemie = pre_enemie.instance()
				enemie_pos_front.add_child(pathfollow)
				pathfollow.add_child(enemie)
				pathfollow.set_offset(360)
				enemie.target_pos = ceil(rand_range(80,320))
				enemie.place = "front"
				enemie.direction = -1
				enemie.tamanho = big_enemie
			0:
				var pathfollow = PathFollow2D.new()
				var enemie = pre_enemie.instance()
				enemie_pos_back.add_child(pathfollow)
				pathfollow.add_child(enemie)
				enemie.target_pos = ceil(rand_range(80,320))
				enemie.direction = 1
				enemie.place = "back"
				enemie.tamanho = small_enemie

func _on_Timer_timeout():
	add_enemy()
	$Timer.wait_time = rand_range(3,6)
