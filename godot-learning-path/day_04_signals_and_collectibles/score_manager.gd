extends Node

var score: int

signal score_updated(value: int)

func _ready() -> void:
	score = 0

func _on_collectible_picked_up(value: int) -> void:
	score += value
	print("Score: ", score)
	score_updated.emit(score)
