extends Panel

@onready var icon_node: TextureRect = $MarginContainer/TextureRect
@onready var count_label: Label = $Label
signal click

var count: int = 0:
	set(v):
		count = v
		count_label.text = str(v)
	get:
		return count
		
var icon: Texture2D:
	set(v):
		icon = v
		icon_node.texture = load(v.resource_path)
	get:
		return icon
		
var selected = false

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if(selected):
		draw_rect(Rect2(0,0, size.x, size.y), Color.WHITE, false, 2)


func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(event.is_pressed() && !event.is_echo()):
			print('dd')
			emit_signal("click")
