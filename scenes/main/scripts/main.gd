extends Control



func _on_snake_button_down() -> void:
	get_tree().change_scene_to_file("res://games/snake/scenes/Snake.tscn")
