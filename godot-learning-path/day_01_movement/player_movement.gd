extends CharacterBody2D

@export var top_speed: float = 300.0
@export var acceleration: float = 10.0

var direction: Vector2
var new_direction: Vector2
var current_speed: float = 0.0

func _ready() -> void:
	current_speed = 0.0	

func _process(delta: float) -> void:
	new_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_direction:
		direction = new_direction
		current_speed = move_toward(current_speed, top_speed, acceleration)
	else:
		current_speed = move_toward(current_speed, 0, acceleration)
	# print(direction)
	
func _physics_process(delta: float) -> void:
	velocity = current_speed * direction
	move_and_slide()
