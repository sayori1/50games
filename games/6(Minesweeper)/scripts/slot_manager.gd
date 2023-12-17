extends GridContainer

const SLOT = preload("res://games/6(Minesweeper)/scenes/Slot.tscn")

@onready var game_over: ColorRect = $"../../GameOver"
@onready var game_won: ColorRect = $"../../GameWon"

@export var width = 10
@export var height = 10

const bomb_population = 0.1

func get_by_xy(x:int,y:int):
	if(x < 0 || y < 0 || x >= width || y >= height):
		return null
	return get_child(y * width + x)
	
func get_xy_by_slot(slot: MinesweeperSlot) -> Vector2i:
	var index = slot.get_index()
	var x = index % width
	var y = floor(index / width)
	return Vector2i(x,y)

func _ready() -> void:
	columns = width
	for i in range(0, width * height):
		var slot = SLOT.instantiate() as MinesweeperSlot
		slot.has_bomb = Utils.randomBoolean(bomb_population)
		
		slot.connect("left_click", func(): left_click(slot))
		slot.connect("right_click", func(): right_click(slot))
		
		add_child(slot)

func left_click(slot: MinesweeperSlot):
	var pos = get_xy_by_slot(slot)
	recursive_reveal(pos.x, pos.y)
	slot.refresh()
	
func right_click(slot: MinesweeperSlot):
	slot.flag = !slot.flag
	slot.refresh()
	
func recursive_reveal(x:int, y:int, reveal_depth = 3, player = true):
	if(reveal_depth == 0):
		return
	
	var slot = get_by_xy(x,y)
	
	if(player && slot != null && slot.has_bomb):
		slot.revealed = true
		slot.refresh()
		make_game_over()
		return
	
	if(slot == null || slot.revealed || slot.has_bomb):
		return
	
	slot.revealed = true
	
	var count = 0
	
	for ix in range(-1, 2, 1):
		for iy in range(-1, 2, 1):
			if(ix == 0 && iy == 0): continue
			var islot = get_by_xy(x + ix, y + iy)
			if(islot == null): continue
			count += 1 if islot.has_bomb else 0 
			recursive_reveal(x + ix, y + iy, reveal_depth - 1, false) 
	slot.number = count 
	slot.refresh()
	if(check_if_player_is_won()):
		game_won.visible = true

func check_if_player_is_won():
	for slot in get_children():
		if(slot.has_bomb && !slot.revealed):
			return false
	return true


func make_game_over():
	game_over.visible = true

