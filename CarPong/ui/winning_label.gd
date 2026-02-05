extends Label
class_name WinningLabel

func _ready() -> void:
	hide()
	Global.set_loser.connect(loser)

func loser(l_name : StringName) -> void:
	var win_name : StringName
	if l_name == &"p1":
		win_name = &"p2"
	else:
		win_name = &"p1"
	text = win_name + " is the winner!"
	show()
