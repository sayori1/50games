extends GridContainer
class_name LetterManager
signal letter_tap(ch:String)

var alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"

const LETTER = preload("res://scenes/letter.tscn")
@onready var type_sound: AudioStreamPlayer2D = $"../TypeSound"

func create_letters():
	for ch in alphabet:
		var letter = LETTER.instantiate()
		letter.text = ch
		letter.connect("button_down", func(): on_letter_tap(ch))
		add_child(letter)

func disable_letter(ch: String):
	var index = alphabet.find(ch)
	print(index)
	(get_child(index) as Button).disabled = true

func on_letter_tap(ch: String):
	emit_signal("letter_tap", ch)
	type_sound.play()

func _ready() -> void:
	create_letters()
