extends Node2D
class_name Missle

var resource: MissleResource
@onready var sprite: Sprite2D = $Sprite2D
var up = true
var is_player = true
var speed

@onready var seed = randi()

@onready var x = position.x
var duration = 0

func _ready() -> void:
	sprite.texture = resource.texture
	if(!up):
		rotate(PI)
	speed = randf_range(resource.speed - resource.speed_rand_range, resource.speed + resource.speed_rand_range)
	print(speed)

func _process(delta: float) -> void:
	duration += delta
	if(up):
		position.y -= speed * delta
	else:
		position.y += speed * delta
	position.x = x - sin(duration + seed) * 20
	if(position.y < -100):
		queue_free()
