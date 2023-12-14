extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func explode():
	await get_tree().create_timer(randf_range(0.1,0.3))
	audio_stream_player_2d.pitch_scale = randf_range(0.9,1.1)
	audio_stream_player_2d.play()
	animated_sprite_2d.play("explosion")
	scale.x = randf_range(0.9, 1.1)
	scale.y = randf_range(0.9, 1.1)
	await animated_sprite_2d.animation_looped
	queue_free()
