extends Node2D
class_name EnemyManager

const ENEMY = preload("res://games/5(Space Invanders)/prefabs/enemy.tscn")
@export var spawn_time_delay = 4

func _ready():
	while(true):
		await get_tree().create_timer(spawn_time_delay).timeout
		var object = ENEMY.instantiate()
		object.global_position = global_position
		object.global_position.x = randf_range(0, get_viewport().size.x)
		object.global_position.y = - 300
		add_child(object)
