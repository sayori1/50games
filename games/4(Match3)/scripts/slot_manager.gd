extends GridContainer
class_name MatchSlotManager
signal slots_exchanged

const SLOT = preload("res://games/4(Match3)/scenes/slot.tscn")
@onready var score_label: Label = $"../../Score"

var from: MatchSlot = null
var to: MatchSlot = null

var is_dragging = false
var is_exchanging = false

var width = 10
var height = 10

var score = 0:
	set(v):
		score = v
		score_label.value = score

func _ready() -> void:
	columns = width
	for y in range(0, height):
		for x in range(0, width):
			var slot = SLOT.instantiate()
			add_child(slot)
	handle_matches()

func get_slot(x:int, y: int) -> MatchSlot:
	return get_child(y * width + x)

func find_horizontal_matches():
	var matches = []
	
	for y in range(0, height):
		var positions: Array[Vector2] = []
		var line: Array[int] = []
		for x in range(0, width):
			var slot = get_slot(x,y)
			if(slot == null || slot.item == null):
				positions.clear()
				line.clear()
				continue
			var cell = slot.item.id
			if(len(line) > 0 && line[-1] == cell):
				line.append(cell)
				positions.append(Vector2(x,y))
			elif(len(line) == 0):
				line = [cell]
				positions = [Vector2(x,y)]
			else:
				if(len(line) >= 3):
					matches.append(positions)
				positions = [Vector2(x,y)]
				line = [cell]
		if(len(line) >= 3):
			for i in positions:
				matches.append(positions)
	return matches
	
func find_vertical_matches():
	var matches = []
	
	for x in range(0, width):
		var positions: Array[Vector2] = []
		var line: Array[int] = []
		for y in range(0, height):
			var slot = get_slot(x,y)
			if(slot == null || slot.item == null):
				positions.clear()
				line.clear()
				continue
			var cell = slot.item.id
			if(len(line) > 0 && line[-1] == cell):
				line.append(cell)
				positions.append(Vector2(x,y))
			elif(len(line) == 0):
				line = [cell]
				positions = [Vector2(x,y)]
			else:
				if(len(line) >= 3):
					matches.append(positions)
				positions = [Vector2(x,y)]
				line = [cell]
		if(len(line) >= 3):
			for i in positions:
				matches.append(positions)
	return matches

func handle_matches():
	var begin = true
	while(true):
		var matches = find_horizontal_matches()
		matches.append_array(find_vertical_matches())
		if(len(matches) == 0):
			return begin
		for _match in matches:
			for slot in _match:
				get_slot(slot.x, slot.y).destroy()
				score += 50
		begin = false
		await fall()
		await generate_top()
	return true

func exchange_slots():
	if(is_exchanging):
		return
	
	is_exchanging = true
	
	await _exchange_slots(from,to)
	var result = await handle_matches()
	if(result):
		_exchange_slots(from,to)

	is_exchanging = false

func _exchange_slots(to: MatchSlot, from: MatchSlot, duration: float = 0.5):
	var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(from.icon, "global_position", to.icon.global_position, duration)
	tween.tween_property(to.icon, "global_position", from.icon.global_position, duration)
	tween.play()
	
	await tween.finished
	
	var buffer = from.item
	from.item = to.item
	to.item = buffer
	
	var buffer_position = to.icon.global_position
	to.icon.global_position = from.icon.global_position
	from.icon.global_position = buffer_position

func fall():
	var falled = false
	for y in range(height, 0, -1):
		var wait = false
		for x in range(0, width):
			var slot = get_slot(x,y)
			if(slot != null && slot.item == null):
				var up_slot = get_slot(x,y-1)
				_exchange_slots(slot, up_slot, 0.1)
				wait = true
				falled = true
		if(wait):
			await get_tree().create_timer(0.12).timeout
	return falled
			
func generate_top():
	while(true):
		var generated = false
		for x in range(0, width):
			if(get_slot(x,0).item == null):
				get_slot(x,0).item = Item.new()
				generated = true
		if(generated):
			await fall()
		else:
			return
