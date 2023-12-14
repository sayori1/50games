extends Label

var value = 0:
	set(v):
		text= str(v) ;
		value = v
@onready var tween = get_tree().create_tween()

func set_value(new_val: int):
	value = new_val
