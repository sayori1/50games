extends Control

class_name MemoryCard

signal left_click

const HIDDEN = preload("res://games/7(MemoryGame)/images/card0.png")

const CARD_1 = preload("res://games/7(MemoryGame)/images/card1.png")
const CARD_2 = preload("res://games/7(MemoryGame)/images/card2.png")
const CARD_3 = preload("res://games/7(MemoryGame)/images/card3.png")
const CARD_4 = preload("res://games/7(MemoryGame)/images/card4.png")
const CARD_5 = preload("res://games/7(MemoryGame)/images/card5.png")
const CARD_6 = preload("res://games/7(MemoryGame)/images/card6.png")
const CARD_7 = preload("res://games/7(MemoryGame)/images/card7.png")
const CARD_8 = preload("res://games/7(MemoryGame)/images/card8.png")
const CARD_9 = preload("res://games/7(MemoryGame)/images/card9.png")
const CARD_10 = preload("res://games/7(MemoryGame)/images/card10.png")
const CARD_11 = preload("res://games/7(MemoryGame)/images/card11.png")
const CARD_12 = preload("res://games/7(MemoryGame)/images/card12.png")
const CARD_13 = preload("res://games/7(MemoryGame)/images/card13.png")
const CARD_14 = preload("res://games/7(MemoryGame)/images/card14.png")
const CARD_15 = preload("res://games/7(MemoryGame)/images/card15.png")
const CARD_16 = preload("res://games/7(MemoryGame)/images/card16.png")
const CARD_17 = preload("res://games/7(MemoryGame)/images/card17.png")
const CARD_18 = preload("res://games/7(MemoryGame)/images/card18.png")
const CARD_19 = preload("res://games/7(MemoryGame)/images/card19.png")
const CARD_20 = preload("res://games/7(MemoryGame)/images/card20.png")
const CARD_21 = preload("res://games/7(MemoryGame)/images/card21.png")

var cards = [CARD_1, CARD_2, CARD_3, CARD_4, CARD_5, CARD_6, CARD_7, CARD_8, CARD_9, CARD_10, CARD_11, CARD_12, CARD_13, CARD_14, CARD_15, CARD_16, CARD_17, CARD_18, CARD_19, CARD_20, CARD_21]
var id = 0
var freezed = false
@onready var texture_rect: TextureRect = $TextureRect

#region Flip handling
var is_flipping = false
var flipped = false

func _flip(alpha:float):
	if(texture_rect.scale.x < 0):
		texture_rect.texture = cards[id]
	else:
		texture_rect.texture = HIDDEN
	texture_rect.scale.x = alpha

func flip():
	while(is_flipping):
		await get_tree().create_timer(0.1).timeout
	is_flipping = true
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	if(!flipped):
		tween.tween_method(_flip, 1.0, -1.0, 0.4)
	else:
		tween.tween_method(_flip, -1.0, 1.0, 0.4)
	flipped = !flipped
	tween.play()
	await tween.finished
	
	is_flipping = false
#endregion

func _process(delta: float) -> void:
	if(!freezed && is_mouse_entered && Input.is_action_just_pressed("ui_click_right")):
		emit_signal("left_click")

var is_mouse_entered = false

func _on_mouse_entered() -> void:
	is_mouse_entered = true


func _on_mouse_exited() -> void:
	is_mouse_entered = false
