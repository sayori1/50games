extends Node2D

var allImages = [
	preload("res://games/5(Space Invanders)/images/Meteors/spaceMeteors_001.png"),
	preload("res://games/5(Space Invanders)/images/Meteors/spaceMeteors_002.png"),
	preload("res://games/5(Space Invanders)/images/Meteors/spaceMeteors_003.png"),
	preload("res://games/5(Space Invanders)/images/Meteors/spaceMeteors_004.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_001.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_002.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_003.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_004.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_005.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_006.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_007.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_008.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_009.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_010.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_011.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_012.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_013.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_014.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_015.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_016.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_017.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_018.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_019.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_020.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_021.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_022.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_023.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_024.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_025.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_026.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_027.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_028.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_029.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_030.png"),
	preload("res://games/5(Space Invanders)/images/Station/spaceStation_031.png")
]

const FALLING_OBJECT = preload("res://games/5(Space Invanders)/prefabs/falling_object.tscn")


@export var offset_y = 200
@export var spawn_time_delay = 1

func _ready():
	while(true):
		await get_tree().create_timer(spawn_time_delay).timeout
		var object = FALLING_OBJECT.instantiate()
		object.texture = allImages.pick_random()
		object.global_position = global_position
		object.global_position.x = randf_range(0, get_viewport().size.x)
		object.global_position.y -= offset_y
		get_tree().current_scene.add_child(object)
