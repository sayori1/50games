extends Sprite2D

var duration = 0
@onready var seed = randi()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	duration += delta
	var alpha = abs(sin(duration + seed) * 0.5)
	modulate.a = 1 - alpha
	scale = Vector2(3 + alpha, 3 + alpha)
	
