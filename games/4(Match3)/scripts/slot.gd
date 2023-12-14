extends TextureRect
class_name MatchSlot
var is_pressed = false

const BUBBLE = preload("res://games/4(Match3)/scenes/bubble.tscn")
@onready var slot_manager: MatchSlotManager = get_parent()
@onready var icon: TextureRect = $MarginContainer/Icon
@onready var item: Item = null:
	set(v):
		item = v
		icon.texture = null if v == null else v.image
	get:
		return item
		
func destroy() -> void:
	var bubble = BUBBLE.instantiate()
	bubble.position.x += 24
	bubble.position.y += 24
	add_child(bubble)
	bubble.explode()
	item = null

func _ready() -> void:
	item = Item.new()

func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(!is_pressed && event.is_pressed()):
			is_pressed = true
			start_dragging()
		else:
			stop_dragging()
			is_pressed = false

func start_dragging():
	if(slot_manager.is_dragging || slot_manager.is_exchanging): return
	slot_manager.is_dragging = true
	slot_manager.from = self
	
func stop_dragging():
	slot_manager.is_dragging = false

func _on_mouse_entered() -> void:
	if(slot_manager.is_dragging && slot_manager.from != null && slot_manager.from.global_position.distance_to(global_position) < Consts.SLOT_SIZE * 2):
		if(slot_manager.from.item.id != item.id):
			slot_manager.to = self
			slot_manager.exchange_slots()

var duration = 0
var seed = randi()
func _process(delta: float) -> void:
	duration += delta
	var alpha = sin(duration + seed) * 0.1
	icon.rotation = alpha
	icon.scale = Vector2(1 + alpha, 1 + alpha)
