extends TextureRect

class_name MinesweeperSlot

signal left_click
signal right_click


#region Images
const img = preload("res://games/6(Minesweeper)/images/1_128x128.png")
const img1 = preload("res://games/6(Minesweeper)/images/2_128x128.png")
const img2 = preload("res://games/6(Minesweeper)/images/3_128x128.png")
const img3 = preload("res://games/6(Minesweeper)/images/4_128x128.png")
const img4 = preload("res://games/6(Minesweeper)/images/5_128x128.png")
const img5 = preload("res://games/6(Minesweeper)/images/6_128x128.png")
const img6 = preload("res://games/6(Minesweeper)/images/7_128x128.png")
const img7 = preload("res://games/6(Minesweeper)/images/8_128x128.png")
const bomb_img = preload("res://games/6(Minesweeper)/images/bomb_128x128.png")
const bomb_exploded_img = preload("res://games/6(Minesweeper)/images/bomb_exploded_128x128.png")
const empty_img = preload("res://games/6(Minesweeper)/images/empty_128x128.png")
const flat_img = preload("res://games/6(Minesweeper)/images/flat_1_128x128.png")
const flat_2_img = preload("res://games/6(Minesweeper)/images/flat_2_128x128.png")
const question_1_img = preload("res://games/6(Minesweeper)/images/question_1_128x128.png")
const question_2_img = preload("res://games/6(Minesweeper)/images/question_2_128x128.png")
const unknown_1_img = preload("res://games/6(Minesweeper)/images/unknown_1_128x128.png")
const unknown_2_img = preload("res://games/6(Minesweeper)/images/unknown_2_128x128.png")

var number_images = [img, img1, img2, img3, img4, img5, img6, img7]


#endregion

var number = 0
var has_bomb = false
var revealed = false
var flag = false

var is_mouse_entered = false

func _on_mouse_entered() -> void:
	is_mouse_entered = true
	modulate.a = 0.7

func _on_mouse_exited() -> void:
	is_mouse_entered = false
	modulate.a = 1
	
func _on_mouse_click() -> void:
	emit_signal("left_click")
	
func _on_mouse_right_click() -> void:
	emit_signal("right_click")
	
func refresh():
	if(!revealed):
		texture = empty_img
	else:
		if(has_bomb):
			texture = bomb_img
		elif(number != 0):
			texture = number_images[number-1]
		else:
			texture = unknown_1_img
	if(flag):
		texture = flat_2_img

func _process(delta: float) -> void:
	if(is_mouse_entered && Input.is_action_just_pressed("ui_click")):
		_on_mouse_click()
	if(is_mouse_entered && Input.is_action_just_pressed("ui_click_right")):
		_on_mouse_right_click()
