extends Node

signal handle

@onready var tetris: Tetris = $".."

const TRIANGLE_FIGURE = [
	[0,0,0,0,1,0,1,1,1],
	[1,0,0,1,1,0,1,0,0],
	[1,1,1,0,1,0,0,0,0],
	[0,0,1,0,1,1,0,0,1]
]

const QUAD_FIGURE = [
	[1,1,0,1,1,0,0,0,0],
	[1,1,0,1,1,0,0,0,0],
	[1,1,0,1,1,0,0,0,0],
	[1,1,0,1,1,0,0,0,0],
]

const LINE_FIGURE = [
	[1,1,1,0,0,0,0,0,0],
	[1,0,0,1,0,0,1,0,0],
	[1,1,1,0,0,0,0,0,0],
	[1,0,0,1,0,0,1,0,0],
]

const LINE_1_FIGURE = [
	[1,1,1,1,0,0,0,0,0],
	[1,1,0,0,1,0,0,1,0],
	[0,0,1,1,1,1,0,0,0],
	[1,0,0,1,0,0,1,1,0],
]

const QUAD_1_FIGURE = [
	[1,1,1,1,1,1,0,0,0],
	[1,1,1,1,1,1,0,0,0],
	[1,1,1,1,1,1,0,0,0],
	[1,1,1,1,1,1,0,0,0],
]

const figures = [TRIANGLE_FIGURE, QUAD_FIGURE, LINE_FIGURE, LINE_1_FIGURE, QUAD_1_FIGURE]

var figure = 0
var active_shape:
	get:
		return figures[figure][active_rotation]
var position = Vector2(5,0)
var active = false
@onready var active_color = randi() % len(tetris.blocks)



var active_rotation = 0:
	set(v):
		if v < 0:
			active_rotation = v + 4
		else:
			active_rotation = v % 4
	get:
		return active_rotation
		
func clear():
	position = Vector2(5,0)
	figure = randi() % len(figures)
	active_rotation = 0
	active_color = randi() % len(tetris.blocks)

func _ready() -> void:
	clear()
	tetris.connect("tick", tick)
	tetris.connect("draw", draw)
	
func tick() -> void:
	if(tetris.ticks % tetris.FALL_EVERY_TICK == 0):
		move(0,1)
	
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("ui_left")):
		emit_signal("handle")
		move(-1,0)
	if(Input.is_action_just_pressed("ui_right")):
		emit_signal("handle")
		move(1,0)
	if(Input.is_action_just_pressed("ui_down")):
		emit_signal("handle")
		move(0,1)
	if(Input.is_action_just_pressed("ui_up")):
		emit_signal("handle")
		active_rotation += 1
	
func move(x:int, y:int, rotate: int = 0):
	var buffer_position = position;
	position += Vector2(x,y)
	if(horizontal_bound_check()):
		position = buffer_position
	if(need_freeze()):
		position = buffer_position
		freeze()
		clear()
		
		
func horizontal_bound_check()->bool:
	for y in range(0, 3):
		for x in range(0, 3):
			if(active_shape[y*3+x] == 1):
				var _x = position.x + x
				if(_x < 0 || _x >= tetris.WIDTH):
					return true
	return false

func need_freeze() -> bool:
	for y in range(0, 3):
		for x in range(0, 3):
			if(active_shape[y*3+x] == 1):
				var _x = position.x + x
				var _y = position.y + y
				if(_y < 0 || _y >= tetris.HEIGHT):
					return true
				if(tetris.is_occupied(_x,_y)):
					return true
	return false
	
func freeze() -> void:
	for y in range(0, 3):
		for x in range(0, 3):
			if(active_shape[y*3+x] == 1):
				var _x = position.x + x
				var _y = position.y + y
				tetris.field[_y][_x]= active_color
	tetris.check_lines()

func draw():
	draw_figure()
	
func draw_figure() -> void:
	for y in range(0, 3):
		for x in range(0, 3):
			if(active_shape[y*3+x] == 1):
				tetris.draw_block(active_color, position.x + x, position.y + y)
