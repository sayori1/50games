extends Control

@onready var iq_label: Label = $IQLabel
@onready var confetti: Node2D = $Confetti
@onready var smarter_than_label: Label = $SmarterThanLabel

var iq = 100

func _ready() -> void:
	iq = MemoryGameGlobal.instance.iq
	run_confetti()
	run_iq_label_anim()

func run_iq_label_anim():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_method(func(alpha):iq_label.text = "Ваш IQ составляет " + str(alpha), 0, iq, 3)
	await tween.finished
	smarter_than_label.text = "Вы умнее " + str(percentage_of_people_with_lower_iq(iq, 8000000000)) + " людей"

func run_confetti():
	for child in confetti.get_children():
		child.emitting = true

func percentage_of_people_with_lower_iq(iq_level: float, total_people: float) -> float:
	var mean_iq = 100
	var std_dev_iq = 15

	var z_score = (iq_level - mean_iq) / std_dev_iq
	var percentage_of_people = 0.5 * (1 + erf(z_score / sqrt(2)))

	var people_with_lower_iq = total_people * percentage_of_people
	return people_with_lower_iq

func erf(x: float) -> float:
	var t = 1.0 / (1.0 + 0.5 * abs(x))
	var erf_value = 1 - t * exp(-x*x - 1.26551223 + t * (1.00002368 + t * (0.37409196 + t * (0.09678418 + t * (-0.18628806 + t * (0.27886807 + t * (-1.13520398 + t * (1.48851587 + t * (-0.82215223 + t * 0.17087277)))))))))
	return erf_value if x >= 0 else -erf_value

func _process(delta: float) -> void:
	pass
