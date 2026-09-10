extends StaticBody2D

@export var start_offset: Vector2
@export var end_offset: Vector2
@export var speed: float
@export var wait_timer: Timer

enum PlatformState {MOVING, WAITING}

var start_position: Vector2
var end_position: Vector2
var target_position: Vector2
var state = PlatformState.MOVING

func _ready() -> void:
	start_position = position + start_offset
	end_position = position + end_offset
	target_position = end_position

func _process(delta: float) -> void:
	if state == PlatformState.WAITING:
		print(wait_timer.time_left)
		if wait_timer.time_left == 0.0:
			state = PlatformState.MOVING
		return
	elif state == PlatformState.MOVING:
		if position == end_position:
			target_position = start_position
			wait_timer.start()
			state = PlatformState.WAITING
		if position == start_position:
			target_position = end_position
			wait_timer.start()
			state = PlatformState.WAITING

func _physics_process(delta: float) -> void:
	print("position: ", position)
	if state == PlatformState.MOVING:
		position.x = move_toward(position.x, target_position.x, speed*delta)
		position.y = move_toward(position.y, target_position.y, speed*delta)
