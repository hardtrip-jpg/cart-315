extends RapierCharacterBody2D
class_name PlayerController

@export var player_tag : StringName = &"p1"
@export var turn_speed : float = 0.2
@export var speed : float = 400
@export var braking :float = -450
@export var max_speed_reverse : float = 250

@export var friction : float = -55
@export var drag : float = -0.06


@export var steering_angle : float = 15
@export var wheel_base : float = 50



@onready var debug_line : Line2D = $DebugLine

var cur_angle : float
var cur_speed : float


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:

	var acceleration : Vector2 = Vector2.ZERO
	
	#Get Input
	var des_angle : float = Input.get_axis("turn_left_" + player_tag, "turn_right_" + player_tag) * deg_to_rad(steering_angle)
	cur_angle = lerp_angle(cur_angle, des_angle, turn_speed)
	
	if Input.is_action_pressed("move_forward_" + player_tag):
		acceleration = transform.x * speed
	if Input.is_action_pressed("move_backward_" + player_tag):
		acceleration = transform.x * braking
	
	
	# Get Drag
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force : Vector2 = velocity * friction * delta
	var drag_force : Vector2 = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	
	
	
	# 1. Find the wheel positions
	var rear_wheel : Vector2 = position - transform.x * wheel_base / 2.0
	var front_wheel : Vector2 = position + transform.x * wheel_base / 2.0
	# 2. Move the wheels forward
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(cur_angle) * delta
	# 3. Find the new direction vector
	var new_heading : Vector2 = rear_wheel.direction_to(front_wheel)
	var d : float = new_heading.dot(velocity.normalized())
	print(d)
	if d > 0:
		velocity = new_heading * velocity.length()
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	velocity += acceleration * delta
	
	debug_line.rotation = cur_angle
	
	move_and_collide(velocity * delta)
