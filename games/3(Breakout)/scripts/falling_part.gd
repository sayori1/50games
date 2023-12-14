extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite

var alpha = 5
var beta = 0

func _process(delta: float) -> void:
	beta += delta
	var x = beta / alpha
	x *= x
	modulate.a = 1 - x
	if(beta >= alpha):
		queue_free()
