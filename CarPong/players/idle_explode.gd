extends Node
class_name IdleExplode

@export var idle_timer : Timer
@export var transition_timer : Timer
@export var recover_timer : Timer
@export var label : Label
@export var min_length : float = 200
@export var idle_length : float = 50

@export var move_speed : float = 0.2
@export var idle_speed : float = 0.5

var parent : PlayerController

var cur_state : String = "Moving"
var idle_timer_length : float

func _ready() -> void:
	parent = get_parent()
	print(parent)
	idle_timer.start()
	idle_timer.paused = true
	recover_timer.timeout.connect(add_to_wait)
	idle_timer.timeout.connect(has_lost)
	transition_timer.timeout.connect(transition)
	idle_timer_length = idle_timer.wait_time

func _physics_process(delta: float) -> void:
	if cur_state == "Moving" and parent.velocity.length() < min_length and transition_timer.is_stopped():
		transition_timer.start()
	elif cur_state == "Idle" and parent.velocity.length() > idle_length and transition_timer.is_stopped():
		transition_timer.start()
	
	if cur_state == "Moving" and parent.velocity.length() > min_length and !transition_timer.is_stopped():
		transition_timer.stop()
	elif cur_state == "Idle" and parent.velocity.length() < idle_length and !transition_timer.is_stopped():
		transition_timer.stop()
	
	label.text = str(int(idle_timer.time_left))

func transition() -> void:
	if cur_state == "Moving":
		cur_state = "Idle"
		idle_timer.paused = false
		recover_timer.stop()
		print(cur_state)
	elif cur_state == "Idle":
		cur_state = "Moving"
		idle_timer.paused = true
		recover_timer.start()


func add_to_wait() -> void:
	var cur_time : float = idle_timer.time_left
	if cur_time >= idle_timer_length:
		recover_timer.stop()
	cur_time += 1
	cur_time = clamp(cur_time, 0, idle_timer_length)
	print(cur_time)
	idle_timer.stop()
	idle_timer.wait_time = cur_time
	idle_timer.start()
	idle_timer.paused = true

func has_lost() -> void:
	if Global.game_not_ended:
		Global.set_loser.emit(parent.player_tag)
		parent.queue_free()
