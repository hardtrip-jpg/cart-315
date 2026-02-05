extends Node


signal set_loser(name : StringName)
signal set_speed(speed : float)
signal update_scr

var game_not_ended : bool = true

var scores : Dictionary[String,int] = {
	"p1": 0,
	"p2": 0
}

func _ready() -> void:
	set_loser.connect(update_score)

func update_score(loser : String) -> void:
	var win_name : StringName
	if loser == &"p1":
		win_name = &"p2"
	else:
		win_name = &"p1"
	scores[win_name] += 1
	update_scr.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		game_not_ended = true
