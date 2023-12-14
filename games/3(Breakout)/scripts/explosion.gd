extends AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	play("default")
	audio_stream_player_2d.play()
	await animation_looped
	queue_free()
