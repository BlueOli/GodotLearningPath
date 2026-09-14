extends CharacterBody2D

@export var point_a: Marker2D
@export var point_b: Marker2D
@export var visual: Polygon2D
@export var collision: CollisionPolygon2D
@export var speed: float

enum EnemyState {PATROL, CHASE}

var target_a: Vector2
var target_b: Vector2
var current_target: Vector2
var current_state = EnemyState.PATROL
var player: Node2D

func _ready() -> void:
	target_a = point_a.global_position
	target_b = point_b.global_position
	current_target = target_a

func _process(delta: float) -> void:
	match current_state:
		EnemyState.PATROL:
			if global_position == current_target:
				if current_target == target_a:
					current_target = target_b
				elif current_target == target_b:
					current_target = target_a
				flip_body()
		EnemyState.CHASE:
			flip_body()
			current_target = player.global_position

func _physics_process(delta: float) -> void:
	match current_state:
		EnemyState.PATROL:
			global_position.x = move_toward(global_position.x, current_target.x, speed * delta)
		EnemyState.CHASE:
			global_position.x = move_toward(global_position.x, current_target.x, speed * delta)

func flip_body() -> void:
	flip(visual)
	flip(collision)
				
func flip(node: Node2D) -> void:
	print("-----")
	print(node.scale.x, " ", global_position.direction_to(current_target).x)
	node.scale.x *= sign((node.scale.x / global_position.direction_to(current_target).x))

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		current_state = EnemyState.CHASE
		player = body

func _on_stop_chase_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		current_state = EnemyState.PATROL
		current_target = target_a
		flip_body()
		player = null
