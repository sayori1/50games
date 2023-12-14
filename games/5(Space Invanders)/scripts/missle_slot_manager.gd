extends HBoxContainer

@onready var spaceship: Spaceship = $"../Spaceship"
const MISSLE_SLOT = preload("res://games/5(Space Invanders)/prefabs/MissleSlot.tscn")

func _ready() -> void:
	spaceship.connect("inventory_update", update)
	update()
	
func update():
	for slot in get_children():
		slot.queue_free()
	for i in range(0, len(spaceship.inventory)):
		var slot = MISSLE_SLOT.instantiate()
		add_child(slot)
		
		slot.icon = spaceship.inventory[i][0].texture
		slot.count = str(spaceship.inventory[i][1])
		
		slot.connect("click", func(): on_slot_click(slot))
	
	get_child(spaceship.current_missle).selected = true
		
func on_slot_click(slot):
	for _slot in get_children():
		if(slot != _slot):
			_slot.selected = false
	slot.selected = !slot.selected;
	if(slot.selected):
		spaceship.current_missle = slot.get_index()
	
