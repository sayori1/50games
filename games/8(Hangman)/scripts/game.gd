extends Control

@onready var letter_manager: LetterManager = $MarginContainer/VBoxContainer/GridContainer
@onready var hangman: Hangman = $MarginContainer/VBoxContainer/Hangman
@onready var guess_label: Label = $MarginContainer/VBoxContainer/GuessLabel

@onready var overlay: Control = $Overlay
@onready var won: NinePatchRect = $Overlay/Won
@onready var game_over: NinePatchRect = $Overlay/GameOver

var words = [
	"яблоко", "банан", "апельсин", "груша", "слива", "вишня", "арбуз", "дыня", "абрикос", "мандарин", "самостоятельность", "дом", "дерижабль", "шар", "магнитофон", "ракета", "окно", "дивергенция", "автократия", "любовь", "добро", "скотч", "лампа", "тесть", "солнце", "луна", "олигарх", "очки", "стол", "улица"
]

var word = words.pick_random()


var correct = 0
var mistakes = 0

func _ready() -> void:
	for i in range(len(word)):
		guess_label.text += "_ "
	letter_manager.connect("letter_tap", on_letter_tap)
	
func on_letter_tap(ch: String):
	var _word: String = word.to_upper()
	if(ch in _word):
		for i in range(len(_word)):
			if(_word[i] == ch):
				guess_label.text[i * 2] = ch
				correct += 1
		if(correct >= len(word)):
			overlay.visible = true
			won.run()
	else:
		mistakes += 1
		if(mistakes >= 6):
			overlay.visible = true
			game_over.run()
		hangman.frame = mistakes
	letter_manager.disable_letter(ch)
