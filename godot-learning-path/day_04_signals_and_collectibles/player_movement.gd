extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_speed: float = 600.0

var direction: float = 0

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.2
	if Input.is_action_just_pressed("jump"):
		jump()
	move_and_slide()

func jump() -> bool:
	if is_on_floor():
		velocity.y += -jump_speed
		return true
	return false

func _on_collectible_body_entered(body: Node2D) -> void:
	print("Collected!")
	print(body)
