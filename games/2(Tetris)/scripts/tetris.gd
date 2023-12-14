extends Control
class_name Tetris

signal tick
signal remove_line

#region consts
const BLUE = preload("res://games/2(Tetris)/images/blue.png")
const DARKGRAY = preload("res://games/2(Tetris)/images/darkgray.png")
const GRAY = preload("res://games/2(Tetris)/images/gray.png")
const GREEN = preload("res://games/2(Tetris)/images/green.png")
const LIGHTBLUE = preload("res://games/2(Tetris)/images/lightblue.png")
const ORANGE = preload("res://games/2(Tetris)/images/orange.png")
const PINK = preload("res://games/2(Tetris)/images/pink.png")
const PURPLE = preload("res://games/2(Tetris)/images/purple.png")
const RED_2 = preload("res://games/2(Tetris)/images/red2.png")
const RED = preload("res://games/2(Tetris)/images/red.png")
const WHITE = preload("res://games/2(Tetris)/images/white.png")

const blocks = [BLUE, GREEN, LIGHTBLUE, ORANGE, PINK, PURPLE, RED, WHITE]

const BLOCK_SIZE = 64
const WIDTH = 10
const HEIGHT = 20

const TICK_DELAY = 0.1
const FALL_EVERY_TICK = 10
#endregion

@onready var score_label: Label = $"../VBoxContainer/Label"

var score = 0:
	set(v):
		score = v
		score_label.value = v

#region drawing
func draw_borders()->void:
	draw_rect(Rect2(0,0, size.x, size.y), Color.GRAY, false, 2)

func _draw() -> void:
	draw_field()
	draw_borders()

func draw_block(id: int, x: int, y: int):
	if(id == -1): return
	draw_texture(blocks[id], Vector2(x,y) * BLOCK_SIZE)
	
func draw_field()->void:
	for y in range(0, HEIGHT):
		for x in range(0, WIDTH):
			draw_block(field[y][x], x, y)
			
#endregion

var field = []
var ticks = 0

func get_cell(x:int,y:int):
	return field[y][x]
	
func is_occupied(x:int, y:int):
	return field[y][x] != -1

func is_free(x:int, y:int):
	return field[y][x] == -1


func generate_field()->void:
	for y in range(0, HEIGHT):
		field.append([])
		for x in range(0, WIDTH):
			field[y].append(-1)

func _ready() -> void:
	generate_field()
	while(true):
		await get_tree().create_timer(TICK_DELAY).timeout
		_tick()

func _tick() -> void:
	ticks += 1
	queue_redraw()
	emit_signal("tick")

func check_lines() -> void:
	for y in range(0, HEIGHT):
		var line_is_occupied = true
		for x in range(0, WIDTH):
			if(is_free(x,y)):
				line_is_occupied = false
		if(line_is_occupied):
			emit_signal("remove_line")
			score += 100
			for x in range(0, WIDTH):
				field[y][x] = -1
			shift(y)

func shift(row:int):
	for y in range(row, 1, -1):
		for x in range(0, WIDTH):
			var buffer = field[y][x]
			field[y][x] = field[y-1][x]
			field[y-1][x] = buffer
