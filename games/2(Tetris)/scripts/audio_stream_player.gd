extends AudioStreamPlayer2D

const MISC_SOUND = preload("res://games/2(Tetris)/audio/misc_sound.wav")
const SAVE = preload("res://games/2(Tetris)/audio/save.wav")

@onready var tetris: Tetris = $"../Tetris"
@onready var figure = $"../Tetris/Figure"

func _ready() -> void:
	tetris.connect("remove_line", remove_line)
	figure.connect("handle", move)
	
func move():
	stream = MISC_SOUND
	pitch_scale = 0.9 + randf() * 0.3
	play()

func remove_line():
	stream = SAVE
	pitch_scale = 0.9 + randf() * 0.3
	play()
	

