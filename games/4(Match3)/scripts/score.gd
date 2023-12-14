extends Label

@export var prefix = "Score: "

var delta_value = 0
var value = 0


func _process(delta: float) -> void:
	delta_value = lerpf(delta_value, value, 0.05)
	text = prefix + str(round(delta_value))
	
	var alpha = (abs(value - delta_value) / 10)
	scale = Vector2(1 + alpha, 1 + alpha)
	scale.x = clamp(scale.x, 1, 1.2)
	scale.y = clamp(scale.y, 1, 1.2)
