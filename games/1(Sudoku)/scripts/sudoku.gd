extends Control

@onready var score_label: Label = $HUD/Score
@onready var mistakes_label: Label = $HUD/Mistakes

const FIELD_SIZE = 64 * 9
const CELL_SIZE = 64
const CELL_TEMPLATE = preload("res://games/1(Sudoku)/prefabs/CellTemplate.tscn")
const LOOP_MAX = 100
const MAX_MISTAKES: int = 3

var cells: Array[Cell]

var score: int = 0:
	set(v):
		score = v
		score_label.text = "Очки: " + str(score)
	get:
		return score

var mistakes: int = 0:
	set(v):
		mistakes = v
		mistakes_label.text = "Ошибки: " + str(mistakes) + "/" + str(MAX_MISTAKES)
	get:
		return mistakes

func _ready() -> void:
	score = 0
	mistakes = 0
	generate()


func _draw() -> void:
	for x in range(0, 10):
		draw_line(Vector2(0,x * CELL_SIZE), Vector2(FIELD_SIZE, x * CELL_SIZE), Color.WHITE, 3 if x % 3 == 0 else 0.5)
	for y in range(0, 10):
		draw_line(Vector2(y * CELL_SIZE, 0), Vector2(y * CELL_SIZE, FIELD_SIZE), Color.WHITE, 3 if y % 3 == 0 else 0.5)

func generate():
	for y in range(0, 9):
		for x in range(0, 9):
			var instance = CELL_TEMPLATE.instantiate()
			instance.connect("request_set_number", func(v): on_request_set_number(instance, v))
			$GridContainer.add_child(instance)
			cells.push_back(instance)
	rm_generate_algorithm()

func get_cell(x:int, y:int)->Cell:
	return cells[y * 9 + x];

func can_place(x:int, y:int, value: int):
	for ix in range(0, 9):
		if(get_cell(ix, y).value == value):
			return false
	
	for iy in range(0, 9):
		if(get_cell(x, iy).value == value):
			return false
			
	var quad_x = ceil(x/3)
	var quad_y = ceil(y/3)
	
	for ix in range(quad_x * 3, (quad_x+1) * 3):
		for iy in range(quad_y * 3, (quad_y+1) * 3):
			if(get_cell(ix, iy).value == value):
				return false
				
	return true

#dumb like me algorithm
func clear():
	for y in range(0, 9):
		for x in range(0, 9):
			get_cell(x,y).value = -1


func rm_generate_algorithm(gaps = 20):
	while(true):
		var result = _rm_generate_algorithm()
		if(result):
			for i in range(0, gaps):
				var x = randi()%9
				var y = randi()%9
				if(get_cell(x,y).value == -1):
					i -= 1
					continue 
				else:
					get_cell(x,y).value = -1
			return true
		else:
			clear()

func _rm_generate_algorithm():
	for y in range(0, 9):
		for x in range(0, 9):
			var i = 0
			while(true):
				if(i < LOOP_MAX):
					i+=1
					var value = 1 + randi() % 9
					if(can_place(x,y, value)):
						get_cell(x,y).value = value
						break;
				else:
					return false;
	return true
				

func on_request_set_number(cell:Cell, value):
	var cell_pos = cells.find(cell)
	
	var y = ceil(cell_pos / 9)
	var x = cell_pos - 9 * y
	
	if(can_place(x,y, value)):
		cell._state = Cell.state.correct
		score += 100
	else:
		score = max(score - 100, 0)
		mistakes += 1
		if(mistakes >= 3):
			$GameOverMenu.visible = true
		cell._state = Cell.state.incorrect
		
	cell.value = value


func _on_replay_button_down() -> void:
	get_tree().change_scene_to_file("res://games/1(Sudoku)/scenes/Sudoku.tscn")
