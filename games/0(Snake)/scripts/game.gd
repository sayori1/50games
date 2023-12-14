extends Control
class_name SnakeGame

const CELL_SIZE: int = 32
const WIDTH: int = 20
const HEIGHT: int = 20

var snake: Snake
var eat_generator: EatGenerator

var score: int = 0:
	set(value):
		score = value
		$Score.set_value(score)

func _ready() -> void:
	snake = Snake.new()
	add_child(snake)

	eat_generator = EatGenerator.new()
	add_child(eat_generator)

	eat_generator.set_target(snake)


class EatGenerator:
	extends Node2D
	var pos: Vector2
	var snake: Snake

	func _init() -> void:
		place_random()

	func set_target(snake: Snake):
		self.snake = snake
		snake.connect("tick", _tick)

	func _tick() -> void:
		var head = snake.head
		if head.x == pos.x && head.y == pos.y:
			place_random()
			snake.add_body()
			get_parent().score += 10
			
			
	func _process(delta: float) -> void:
		queue_redraw()

	func _draw() -> void:
		draw_rect(
			Rect2(pos.x * CELL_SIZE, pos.y * CELL_SIZE, CELL_SIZE, CELL_SIZE), Color.YELLOW, true
		)

	func place_random():
		while true:
			pos = Vector2(randi_range(0, WIDTH), randi_range(0, HEIGHT))
			if snake == null || not pos in snake.body:
				break


class Snake:
	extends Node2D
	signal tick
	var dir: Vector2 = Vector2.RIGHT
	var body: Array[Vector2] = [
		Vector2.ZERO, Vector2.ZERO + Vector2.RIGHT, Vector2.ZERO + Vector2.RIGHT * 2
	]

	var head:
		get:
			return body[len(body) - 1]

	func _ready() -> void:
		start_moving_cycle()

	func _process(delta: float) -> void:
		queue_redraw()
		var movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if movement != Vector2.ZERO && !Utils.areVectorsCollinear(movement, dir):
			dir = movement

	func check_if_eats_itself():
		for i in range(0, len(body) - 2):
			if body[i] == head:
				return true
		return false

	func start_moving_cycle() -> void:
		while true:
			await get_tree().create_timer(0.05).timeout
			handle_move()
			emit_signal("tick")
			if check_if_eats_itself():
				$"../GameOverMenu".visible = true
				queue_free()

	func handle_move():
		var temp_body = body.duplicate(true)
		body[len(body) - 1] += dir

		for i in range(0, len(body) - 1):
			body[i] = temp_body[i + 1]
		
		check_if_exits()

	func add_body():
		body.push_front(body[0] - (body[1] - body[0]))
		
	func check_if_exits():
		for i in range(0, len(body)):
			body[i].x = (body[i].x as int) % (WIDTH+1)
			body[i].y = (body[i].y as int) % (HEIGHT+1)
			
			if(body[i].x < 0):
				body[i].x = WIDTH - body[i].x
				
			if(body[i].y < 0):
				body[i].y = WIDTH - body[i].y
			
			

	func _draw():
		for point in body:
			draw_rect(
				Rect2(point.x * CELL_SIZE, point.y * CELL_SIZE, CELL_SIZE, CELL_SIZE),
				Color.GREEN_YELLOW,
				true
			)


func _on_replay_button_down() -> void:
	get_tree().change_scene_to_file("res://games/0(Snake)/scenes/Snake.tscn")
