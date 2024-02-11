extends Control

@onready var grid_container: CardManager = $CenterContainer/GridContainer
@onready var timer_label: Label = $VBoxContainer/TimerLabel

var elapsed = 0:
	set(v):
		timer_label.text = str(round(v))
		elapsed = v

func _ready() -> void:
	grid_container.connect("won", on_won)
	
func on_won() -> void:
	MemoryGameGlobal.instance.iq = 70+1000/elapsed
	get_tree().change_scene_to_file("res://games/7(MemoryGame)/scenes/result_scene.tscn")
	
func _process(delta: float) -> void:
	elapsed += delta
