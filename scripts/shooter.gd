extends KinematicBody2D
class_name player

const bullet = preload("res://scenes/bullet_player.tscn")
const mouse_cursor = preload("res://assets/mouse/muzzle_mouse.png")

enum{
	MOVE,
	STOPPED,
	BACKFLIP,
}

var current_state = STOPPED

var shoting : bool = false

var screen_size

onready var player_info : Node = (get_node("/root/player_information") as Node)
onready var tween : Tween = ($Tween as Tween)
onready var animatedsprite : AnimatedSprite = ($AnimatedSprite as AnimatedSprite)

var speed : int = 90

var velocity : Vector2 = Vector2(0,0)

#FUNCTIONS TYPE VOIDS
func _ready() -> void:
	$AnimatedSprite.play("idle")
	screen_size = get_viewport_rect().size

func _process(delta) -> void:
	if get_global_mouse_position().x > (screen_size.x/2):
		animatedsprite.scale.x = -1
	else:
		animatedsprite.scale.x = 1
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	var dir := get_global_mouse_position() - global_position
	
	if dir.length() > 5:
		($dir_node as Node2D).rotation = dir.angle()
	
	move_shooter(delta)

func _input(event) -> void:
	if Input.is_action_just_pressed("mouse_left") and current_state == STOPPED:
		fire_bullet()

#FUNCTIONS NOT VOID
func fire_bullet() :
	var bullet_project = (bullet.instance() as KinematicBody2D)
	bullet_project.position = get_global_mouse_position()
	get_parent().add_child(bullet_project)

func move_shooter(delta):
	get_tree().get_root()
	if Input.is_key_pressed(KEY_A):
		if Input.is_key_pressed(KEY_SHIFT):
			tween.interpolate_property(self, "position",position, Vector2(position.x + -100, position.y), 0.7,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			animatedsprite.play("back_flip")
			current_state = BACKFLIP
			($CollisionShape2D as CollisionShape2D).disabled = true
	if Input.is_key_pressed(KEY_D):
		if Input.is_key_pressed(KEY_SHIFT):
			tween.interpolate_property(self, "position",position, Vector2(position.x + 100, position.y), 0.7,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			animatedsprite.play("back_flip")
			current_state = BACKFLIP
			($CollisionShape2D as CollisionShape2D).disabled = true
		
	
	var direction = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if direction != 0 and current_state != BACKFLIP:
		current_state = MOVE
	
	if direction == 0 and current_state != BACKFLIP:
		current_state = STOPPED
	
	velocity.x = direction * speed
	velocity = move_and_slide(velocity)

#SIGNALS
func _on_shoot_time_timeout():
	shoting = false

func _on_Tween_tween_all_completed():
	current_state = STOPPED
	animatedsprite.play("idle")
	($CollisionShape2D as CollisionShape2D).disabled = false
