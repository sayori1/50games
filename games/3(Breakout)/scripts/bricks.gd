extends Node2D

const BRICK = preload("res://games/3(Breakout)/prefabs/brick.tscn")
@onready var label: Label = $"../Control/Label"

@export var width: int = 7
@export var height: int = 3

func _ready() -> void:
	var pointer = global_position
	for y in range(0, height):
		for x in range(0, width):
			var brick = BRICK.instantiate()
			add_child(brick)
			pointer.x = x * brick.size.x / 2
			pointer.y = y * brick.size.y / 2
			brick.position = pointer

func _process(delta: float) -> void:
	if get_child_count() == 0:
		label.start()
