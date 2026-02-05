extends RapierRigidBody2D

var dif : float = 0.01
var increase_speed : float = 0.5

var timer : Timer

@export var area : RapierArea2D

func _ready() -> void:
	randomize()
	apply_central_impulse(Vector2(randf_range(-1,1),randf_range(-1,1)).normalized() * 0.2)
	timer = Timer.new()
	timer.wait_time = increase_speed
	timer.timeout.connect(bounce)
	timer.one_shot = false
	add_child(timer)
	timer.start()
	area.body_entered.connect(body_entered)
	Global.set_speed.emit(linear_velocity.length())
	

func bounce() -> void:
	if linear_velocity.length() < 1300:
		apply_central_impulse(linear_velocity.normalized() * dif)
		Global.set_speed.emit(linear_velocity.length())
	else:
		timer.stop()

func body_entered(body : Node2D) -> void:
	if body is PlayerController && Global.game_not_ended:
		Global.game_not_ended = false
		Global.set_loser.emit(body.player_tag)
		body.queue_free()
