extends Label

@onready var panel: Panel = $"../Panel"



func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(event.is_pressed() && !event.is_echo()):
			panel.visible = !panel.visible

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
		panel.visible = false
