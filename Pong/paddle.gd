extends CharacterBody2D
class_name Paddle

@export var player_id : String = "p1"

var speed : float = 500
var accel : float = 0.05

var window_height : float
var bounds : float = 100

func _ready() -> void:
	window_height = get_viewport().get_visible_rect().end.y

func _physics_process(delta: float) -> void:
	
	var desired_vel : float = 0
	
	if Input.is_action_pressed("up_" + player_id) && global_position.y >= bounds:
		desired_vel -= speed
	if Input.is_action_pressed("down_" + player_id) && global_position.y <= window_height - bounds:
		desired_vel += speed
	
	print(global_position)
	
	velocity.y = lerpf(velocity.y, desired_vel, accel)
	move_and_slide()
