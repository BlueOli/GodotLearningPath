extends Label

func _ready() -> void:
	text = ("Score: " + str(0))

func _on_score_manager_score_updated(value: int) -> void:
	text = ("Score: " + str(value))
