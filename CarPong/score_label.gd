extends Label

func _ready() -> void:
	set_score()
	Global.update_scr.connect(set_score)

func set_score() -> void:
	text = "P1: " + str(Global.scores["p1"]) + " P2: " + str(Global.scores["p2"])
