extends Camera2D

@export var pos_label : Label

func _process(delta: float) -> void:
	pos_label.text = str(global_position)
