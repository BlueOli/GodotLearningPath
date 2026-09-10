extends StaticBody2D

@export var is_open: bool
@export var is_one_time_open: bool
@export var collision: CollisionShape2D
@export var open_visual: Polygon2D
@export var closed_visual: Polygon2D

func open() -> bool:
	if !is_open:
		is_open = !is_open
		collision.set_deferred("disabled", true)
		open_visual.visible = !open_visual.visible
		closed_visual.visible = !closed_visual.visible
		return true
	return false

func close() -> bool:
	if is_open:
		is_open = !is_open
		collision.set_deferred("disabled", false)
		open_visual.visible = !open_visual.visible
		closed_visual.visible = !closed_visual.visible
		return true
	return false

func _on_pressure_plate_state_changed(state: bool) -> void:
	if state:
		if open():
			print("Open!")
	if !state and !is_one_time_open:
		if close():
			print("Closed!")
