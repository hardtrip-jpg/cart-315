extends Label
class_name ScoreManager

var current_score : int = 0

func _ready() -> void:
	Global.add_score.connect(add_score)
	text = "Score: " + str(current_score)
	
func add_score(add : int) -> void:
	current_score += add
	text = "Score: " + str(current_score)
