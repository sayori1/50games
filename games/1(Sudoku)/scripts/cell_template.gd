extends Control
class_name Cell
signal request_set_number

enum state {
	correct,
	incorrect,
	default
}

var value = -1:
	set(v):
		if(v == -1):
			%Label.text = ""
		else:
			%Label.text = str(v)
		value = v
	get:
		return value
		

var _state: state = state.default:
	set(v):
		_state = v
		if(_state == state.correct):
			%Label.modulate = Color.GREEN
		elif(_state == state.incorrect):
			%Label.modulate = Color.RED
		else:
			%Label.modulate = Color.WHITE
	get:
		return _state


var is_mouse_entered = false

func _input(event: InputEvent) -> void:
	var rect = get_global_rect()
	var mouse_position = get_global_mouse_position()
	is_mouse_entered = rect.has_point(mouse_position)
	if(is_mouse_entered && event is InputEventKey && event.is_pressed() && !event.is_echo()):
		if(event.keycode >= 48 && event.keycode <= 57):
			emit_signal("request_set_number", event.keycode - 48)
