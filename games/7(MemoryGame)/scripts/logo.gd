extends Control

@onready var initial_position_y = position.y
var elapsed = 0

func _process(delta: float) -> void:
	elapsed += delta
	global_position.y = initial_position_y + sin(elapsed) * 10 
	
	var alpha = abs(sin(elapsed)) * 0.05
	scale = Vector2(1 + alpha, 1 + alpha)
	rotation = sin(elapsed) * 0.05
