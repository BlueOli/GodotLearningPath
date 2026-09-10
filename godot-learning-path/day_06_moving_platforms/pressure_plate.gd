extends Node2D

@export var is_active: bool
@export var shape: Polygon2D

signal state_changed(state: bool)

func activate() -> bool:
	if !is_active:
		is_active = !is_active
		return true
	return false

func deactivate() -> bool:
	if is_active:
		is_active = !is_active
		return true
	return false	

func low_plate_visual():
	shape.global_position.y += 5

func high_plate_visual():
	shape.global_position.y -= 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if activate():
		print("Plate activated")
		state_changed.emit(is_active)
		low_plate_visual()
	else:
		print("Error activating plate")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if deactivate():
		print("Plate deactivated")
		state_changed.emit(is_active)
		high_plate_visual()
	else:
		print("Error deactivating plate")
