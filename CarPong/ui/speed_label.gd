extends Label

var cur_speed : float
var displayed_speed : float
var number_shown_speed : float = 0.25

func _ready() -> void:
	Global.set_speed.connect(func(speed : float) -> void: cur_speed = speed)

func _physics_process(delta: float) -> void:
	displayed_speed = lerpf(displayed_speed, cur_speed, number_shown_speed * delta)
	text = "Ball Speed: " + str(int(displayed_speed))
