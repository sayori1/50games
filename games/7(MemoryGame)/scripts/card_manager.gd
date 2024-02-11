extends GridContainer
class_name CardManager

signal won

const CARD = preload("res://games/7(MemoryGame)/scenes/card.tscn")

var width = 4
var height = 4

var correct_count = 0:
	set(v):
		correct_count = v
		if(correct_count >= (width*height)/2):
			print('won!')
			emit_signal("won")

var sequence = range(21)

func _ready() -> void:
	sequence.shuffle()
	columns = width
	var children = []
	
	for i in range(0, width*height):
		var j = floor(i / 2)
		var card = CARD.instantiate()
		card.id = j
		card.connect("left_click", func(): card_click(card))
		children.push_back(card)

	children.shuffle()
	for child in children:
		add_child(child)

var prev: MemoryCard
var stack = []

func card_click(card:MemoryCard):
	card.flip()
	stack.append(card)
	if(len(stack) >= 2):
		for i in range(0, len(stack) - 2):
			stack[i].flip()
		stack = [stack[-2], stack[-1]]
		if(stack[-2].id == stack[-1].id && stack[-2].name != stack[-1].name):
			for slot in stack:
				slot.freezed = true
				slot.freezed = true
			correct_count += 1
		else:
			await get_tree().create_timer(0.5).timeout
			for slot in stack:
				slot.flip()
		stack.clear()
