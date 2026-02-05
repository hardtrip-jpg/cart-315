extends Area2D
class_name CollisionArea

func _ready() -> void:
	body_entered.connect(when_enter)

func when_enter(body: Node2D) -> void:
	if body is Item:
		Global.add_score.emit(body.score_amount)
		body.queue_free()
