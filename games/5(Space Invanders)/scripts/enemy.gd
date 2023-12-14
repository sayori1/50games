extends Sprite2D

const SPACE_SHIPS_001 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_001.png")
const SPACE_SHIPS_002 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_002.png")
const SPACE_SHIPS_003 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_003.png")
const SPACE_SHIPS_004 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_004.png")
const SPACE_SHIPS_005 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_005.png")
const SPACE_SHIPS_006 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_006.png")
const SPACE_SHIPS_008 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_008.png")
const SPACE_SHIPS_009 = preload("res://games/5(Space Invanders)/images/Ships/spaceShips_009.png")

var images = [SPACE_SHIPS_001, SPACE_SHIPS_002, SPACE_SHIPS_003, SPACE_SHIPS_004, SPACE_SHIPS_005, SPACE_SHIPS_006, SPACE_SHIPS_008, SPACE_SHIPS_009]
enum behaviour {STATIC, MOVING}

var _behaviour = behaviour.keys().pick_random()

const EXPLOSION = preload("res://games/5(Space Invanders)/prefabs/explosion.tscn")
const MISSLE = preload("res://games/5(Space Invanders)/prefabs/Missle.tscn")
const _2 = preload("res://games/5(Space Invanders)/resources/missles/2.tres")

@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint
@onready var init_x = position.x
@onready var radius = randf_range(100, 300) 
var duration = 0

var dead = false


func _ready() -> void:
	texture = images.pick_random()
	while(!dead):
		await get_tree().create_timer(5).timeout
		if(dead):
			return
		var missle = MISSLE.instantiate()
		missle.up = false
		missle.resource = _2
		missle.global_position = bullet_spawn_point.global_position
		missle.is_player = false
		missle.rotate(rotation)
		get_tree().current_scene.add_child(missle)
		missle.z_index = -10

func _process(delta: float) -> void:
	duration += delta
	position.y += 30 * delta
	if(_behaviour == "MOVING"):
		position.x = init_x + sin(duration) * radius
		
	if(dead):
		position.y += 200 * delta
		rotate(1 * delta)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Missle):
		var missle: Missle = area.get_parent()
		if(!missle.is_player):
			return

		missle.queue_free()
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		var spaceship = get_tree().current_scene.get_node("%Spaceship")
		
		spaceship.money += 300
		spaceship.xp += 100
		
		$Area2D.queue_free()
		dead = true
		modulate.a = 0.4
