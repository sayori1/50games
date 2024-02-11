extends NinePatchRect

@onready var confetti: Node2D = $Confetti
@onready var win_sound: AudioStreamPlayer2D = $WinSound

func run():
	visible = true
	if(confetti == null):
		return
	win_sound.play()
	for child in confetti.get_children():
		child.emitting = true

func on_replay_button_down() -> void:
	get_tree().change_scene_to_file("res://games/8(Hangman)/scenes/main.tscn")


func on_exit_button_down() -> void:
	get_tree().quit()
