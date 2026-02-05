extends Node
class_name Spawner

@export var timer_time_range : Vector2
@export var item_list : Array[PackedScene]


var window_size : float
var timer : Timer


func _ready() -> void:
	window_size = get_viewport().get_visible_rect().end.x
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(timeout)
	timer.wait_time = randf_range(timer_time_range.x, timer_time_range.y)
	timer.start()

func timeout() -> void: 
	
	var spawn_location : float = randf_range(0, window_size)
	var new_item : PackedScene = item_list.pick_random()
	var item : Item = new_item.instantiate()
	item.global_position = Vector2(spawn_location, -20)
	add_child(item)
	
	
	timer.wait_time = randf_range(timer_time_range.x, timer_time_range.y)
	timer.start()
