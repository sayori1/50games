extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://games/8(Hangman)/scenes/main.tscn")


func _on_settings_button_down() -> void:
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
