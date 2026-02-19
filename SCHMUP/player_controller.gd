extends CharacterBody2D
class_name PlayerController

@export var player_speed : float = 100


@export var bullet_speed : float = 10

@export var death_area : DeathArea
@export var bullet_spawn : Marker2D

var direction : int = 0
var window_size : Vector2

func _ready() -> void:
	window_size = get_viewport_rect().size

func _input(event: InputEvent) -> void:
	direction = 0
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	velocity = Vector2(direction, 0) * player_speed
	move_and_slide()

func shoot() -> void:
	var new_bullet : Bullet = Bullet.new(bullet_spawn.global_position, bullet_speed, up_direction, 3, null)
	add_child(new_bullet)
