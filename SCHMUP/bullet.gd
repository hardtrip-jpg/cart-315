extends Area2D
class_name Bullet

var speed : float
var direction : Vector2
var life_time : float

func _init(p_pos: Vector2, p_speed : float, p_direction : Vector2, p_life_time : float, p_bullet_col : CollisionShape2D) -> void:
	global_position = p_pos
	speed = p_speed
	direction = p_direction.normalized()
	life_time = p_life_time
	
	if p_bullet_col:
		add_child(p_bullet_col)
	else:
		var new_col := CollisionShape2D.new()
		new_col.shape = CircleShape2D.new()
		new_col.shape.radius = 10
		add_child(new_col)
	
	

func _ready() -> void:
	top_level = true
	print("huh")
	#Set Timer
	var timer := Timer.new()
	timer.wait_time = life_time
	timer.timeout.connect(func() -> void: queue_free())
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _physics_process(delta: float) -> void:
	global_position += (direction * speed)
