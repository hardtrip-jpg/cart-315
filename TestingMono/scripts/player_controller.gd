extends CharacterBody2D
class_name PlayerController

@export var speed : float = 500
@export var acceleration : float = 0.5

var window_size : float

func _ready() -> void:
	window_size = get_viewport().get_visible_rect().end.x
	print(window_size)

func _physics_process(delta: float) -> void:
	
	var desired_vel : float = 0
	if Input.is_action_pressed("left") and global_position.x >= 0:
		desired_vel -= speed
	if Input.is_action_pressed("right") and global_position.x <= window_size:
		desired_vel += speed
	
	
	velocity.x = lerp(velocity.x, desired_vel, acceleration)
	move_and_slide()
