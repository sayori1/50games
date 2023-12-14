extends CharacterBody2D

@onready var initial_y = global_position.y

const SPEED = 1000.0

func _physics_process(delta: float) -> void:
	velocity.y = 0
	global_position.y = initial_y
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Ball"):
		var rigidbody2d: RigidBody2D = body as RigidBody2D
		rigidbody2d.apply_impulse(Vector2.UP * 25)
