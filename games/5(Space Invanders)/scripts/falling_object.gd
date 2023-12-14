extends Sprite2D

@onready var rotate_speed = randf_range(0.2, 1.4)
@onready var vertical_speed = randf_range(90, 150)
@onready var scale_multiplier = randf_range(0.5, 1.2)
@onready var alpha = randf_range(0.1, 0.3)

func _ready() -> void:
	modulate.a = alpha
	scale = Vector2(scale_multiplier, scale_multiplier)

func _process(delta: float) -> void:
	rotate(rotate_speed * delta)
	position.y += vertical_speed * delta
	if(position.y > 2000):
		queue_free()
