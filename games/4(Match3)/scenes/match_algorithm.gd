extends Node2D

const GOLDMAN_BOLD = preload("res://fonts/Goldman-Bold.ttf")
var cells = []
var cells_check = []


func _ready() -> void:
	for y in range(0, 10):
		cells.append([])
		cells_check.append([])
		for x in range(0, 10):
			cells[y].append(randi_range(0,1))
			cells_check[y].append(false)
	#find_horizontal_matches()
	find_vertical_matches()
			

func _draw() -> void:
	for y in range(0, 10):
		for x in range(0, 10):
			draw_rect(Rect2(x*32,y*32, 32, 32), 
			Color.LIME_GREEN, cells_check[y][x])
			draw_string(GOLDMAN_BOLD, Vector2(x*32 + 10, y*32 + 18), str(cells[y][x]))

func find_horizontal_matches():
	var matches = []
	
	for y in range(0, 10):
		var positions: Array[Vector2] = []
		var line: Array[int] = []
		for x in range(0, 10):
			var cell = cells[y][x]
			if(len(line) > 0 && line[-1] == cell):
				line.append(cell)
				positions.append(Vector2(x,y))
			elif(len(line) == 0):
				line = [cell]
				positions = [Vector2(x,y)]
			else:
				if(len(line) >= 3):
					for i in positions:
						cells_check[i.y][i.x] = true
					matches.append(positions)
				positions = [Vector2(x,y)]
				line = [cell]
		if(len(line) >= 3):
			for i in positions:
				cells_check[i.y][i.x] = true
				matches.append(positions)
	return matches
	
func find_vertical_matches():
	var matches = []
	
	for x in range(0, 10):
		var positions: Array[Vector2] = []
		var line: Array[int] = []
		for y in range(0, 10):
			var cell = cells[y][x]
			if(len(line) > 0 && line[-1] == cell):
				line.append(cell)
				positions.append(Vector2(x,y))
			elif(len(line) == 0):
				line = [cell]
				positions = [Vector2(x,y)]
			else:
				if(len(line) >= 3):
					for i in positions:
						cells_check[i.y][i.x] = true
					matches.append(positions)
				positions = [Vector2(x,y)]
				line = [cell]
		if(len(line) >= 3):
			for i in positions:
				cells_check[i.y][i.x] = true
				matches.append(positions)
	return matches
