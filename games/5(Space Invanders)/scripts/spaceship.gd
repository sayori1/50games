extends Node2D
class_name Spaceship

signal inventory_update

@onready var bullet_spawn_points: Node2D = $BulletSpawnPoints
const MISSLE = preload("res://games/5(Space Invanders)/prefabs/Missle.tscn")

@onready var xp_label: Label = $"../XpLabel"
@onready var money_label: Label = $"../MoneyLabel"
@onready var game_over: ColorRect = $"../GameOver"

const EXPLOSION = preload("res://games/5(Space Invanders)/prefabs/explosion.tscn")
var inventory = [[preload("res://games/5(Space Invanders)/resources/missles/0.tres"), 10], [preload("res://games/5(Space Invanders)/resources/missles/2.tres"), 5]]:
	set(v):
		inventory = v
		emit_signal("inventory_update")
var current_missle = 0

var speed = 300
var money = 100:
	set(v):
		money = v
		money_label.text =  str(v) + "$"
	get:
		return money

var xp = 0:
	set(v):
		xp = v
		xp_label.text =  str(v) + "xp"
	get:
		return xp


func take_missle_or_null():
	if(inventory.is_empty()):
		return null
	if(current_missle >= len(inventory)):
		current_missle = 0
	var missle_slot = inventory[current_missle]
	missle_slot[1] -= 1
	if(missle_slot[1] == 0):
		inventory.remove_at(current_missle)
	emit_signal("inventory_update")
	return missle_slot[0]

func _process(delta: float) -> void:
	global_position.y = get_viewport().size.y - 200
	if(Input.is_action_just_pressed("ui_space")):
		shot()
	if(Input.is_action_pressed("ui_right")):
		position.x += speed * delta
	if(Input.is_action_pressed("ui_left")):
		position.x -= speed * delta

func wait_n_spawn_bullet(spawn_point):
	var missle_resource = take_missle_or_null()
	if(missle_resource == null):
		return
	var missle = MISSLE.instantiate()
	missle.resource = missle_resource
	await get_tree().create_timer(randf_range(0,0.5)).timeout
	missle.global_position = spawn_point.global_position
	get_tree().current_scene.add_child(missle)

var shot_iter = 0
func shot():
	shot_iter += 1
	shot_iter = shot_iter % bullet_spawn_points.get_child_count()
	wait_n_spawn_bullet(bullet_spawn_points.get_child(shot_iter))

func buy(missle_resource:MissleResource, price:int = 40, count: int = 1):
	if(price > money):
		return
	money -= price
	var added = false
	for item in inventory:
		if(item[0] == missle_resource):
			item[1] += count
			added = true
	if(!added):
		inventory.push_back([missle_resource, count])
	emit_signal("inventory_update")
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Missle):
		var missle: Missle = area.get_parent()
		if(missle.is_player):
			return

		missle.queue_free()
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		
		await get_tree().create_timer(0.5).timeout
		game_over.visible = true
		
		
