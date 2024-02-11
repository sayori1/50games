extends TextureRect
class_name Hangman

const HANGMAN = preload("res://games/8(Hangman)/assets/textures/hangman.png")
const width = 165
const height = 283

var frame = 0:
	set(v):
		frame = v % 7
		var sub_texture:AtlasTexture = AtlasTexture.new()
		sub_texture.atlas = HANGMAN
		sub_texture.region = Rect2(frame * width, 0, width, height)
		texture = sub_texture
		
func _ready() -> void:
	frame = 0


