extends StaticBody2D

const _01_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/01-Breakout-Tiles.png")
const _02_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/02-Breakout-Tiles.png")
const _03_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/03-Breakout-Tiles.png")
const _04_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/04-Breakout-Tiles.png")
const _05_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/05-Breakout-Tiles.png")
const _06_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/06-Breakout-Tiles.png")
const _07_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/07-Breakout-Tiles.png")
const _08_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/08-Breakout-Tiles.png")
const _09_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/09-Breakout-Tiles.png")
const _10_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/10-Breakout-Tiles.png")
const _11_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/11-Breakout-Tiles.png")
const _12_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/12-Breakout-Tiles.png")
const _13_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/13-Breakout-Tiles.png")
const _14_BREAKOUT_TILES = preload("res://games/3(Breakout)/images/14-Breakout-Tiles.png")

const EXPLOSION = preload("res://games/3(Breakout)/prefabs/explosion.tscn")
const FALLING_PART = preload("res://games/3(Breakout)/prefabs/falling_part.tscn")


var tiles = [_01_BREAKOUT_TILES, _02_BREAKOUT_TILES, _03_BREAKOUT_TILES, _04_BREAKOUT_TILES, _05_BREAKOUT_TILES, _06_BREAKOUT_TILES, _07_BREAKOUT_TILES, _08_BREAKOUT_TILES, _09_BREAKOUT_TILES, _10_BREAKOUT_TILES, _11_BREAKOUT_TILES, _12_BREAKOUT_TILES, _13_BREAKOUT_TILES, _14_BREAKOUT_TILES]

@onready var sprite: Sprite2D = $Sprite
var size:Vector2:
	get:
		return sprite.get_rect().size

func _ready() -> void:
	sprite.texture = tiles[randi() % len(tiles)]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Ball"):
		for i in range(0, 5):
			create_explosion()
		queue_free()


func create_explosion():
	var expl = EXPLOSION.instantiate()
	expl.global_position = global_position
	expl.global_position += Vector2(-100 + randi()%200, -100 + randi()%200)
	expl.scale = Vector2(randf_range(0.8, 2), randf_range(0.8, 3))
	get_parent().add_child(expl)
	create_falling_part()
	
func create_falling_part():
	var fall_part = FALLING_PART.instantiate()
	get_parent().add_child(fall_part)
	fall_part.global_position = global_position + Vector2(randf_range(0, 100), randf_range(0,100))
	fall_part.sprite.texture = get_cropped_texture(sprite.texture, Rect2(randi_range(0, 4) * size.x/4,randi_range(0, 4) * size.y/randi_range(1,6), size.x / randi_range(5,9), size.y / randi_range(5,9) ))
	fall_part.rotation = randf()
	fall_part.apply_impulse(Vector2.from_angle(randf_range(0, 3.14)) * 1000)
	

func get_cropped_texture(texture : Texture, region : Rect2) -> AtlasTexture:
	var atlas_texture := AtlasTexture.new()
	atlas_texture.set_atlas(texture)
	atlas_texture.set_region(region)
	return atlas_texture
