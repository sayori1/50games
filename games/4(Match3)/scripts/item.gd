extends Node
class_name Item

const _3 = preload("res://games/4(Match3)/images/ico/3.png")
const _6 = preload("res://games/4(Match3)/images/ico/6.png")
const _7 = preload("res://games/4(Match3)/images/ico/7.png")
const _8 = preload("res://games/4(Match3)/images/ico/8.png")
const _9 = preload("res://games/4(Match3)/images/ico/9.png")
const _10 = preload("res://games/4(Match3)/images/ico/10.png")
const _11 = preload("res://games/4(Match3)/images/ico/11.png")
const _14 = preload("res://games/4(Match3)/images/ico/14.png")
const _15 = preload("res://games/4(Match3)/images/ico/15.png")
const _17 = preload("res://games/4(Match3)/images/ico/17.png")
const _21 = preload("res://games/4(Match3)/images/ico/21.png")


var images = [_3, _6, _7, _8, _9, _10, _11, _14, _15,_17, _21]
var id = 0
var image: Texture2D:
	get:
		if(id == -1):
			return null
		return images[id]
		

func _init() -> void:
	id = randi_range(0, len(images)-1)
