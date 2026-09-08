extends Area2D

@export var value: int
@export var color: Color
@export var Shape: Polygon2D
@export var scale_mult: float

func _ready() -> void:
	Shape.color = color
	scale *= scale_mult

signal picked_up(value: int)

func _on_body_entered(body: Node2D) -> void:
	picked_up.emit(value)
	queue_free()
