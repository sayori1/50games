extends Node2D

@onready var expl_1: AnimatedSprite2D = $Expl1
@onready var expl_2: AnimatedSprite2D = $Expl2
@onready var expl_3: AnimatedSprite2D = $Expl3

func _ready() -> void:
	var s1 = randf_range(0.8, 1.7)
	var s2 = randf_range(0.8, 1.7)
	var s3 = randf_range(0.8, 1.7)
	
	expl_1.scale = Vector2(s1,s1)
	expl_2.scale = Vector2(s2,s2)
	expl_3.scale = Vector2(s3,s3)
	
	expl_1.position.x -= randf_range(0,10)
	expl_2.position.y -= randf_range(0,10)
	
	
	expl_1.play("default")
	expl_2.play("default")
	expl_3.play("default")
	
	await get_tree().create_timer(0.8).timeout
	visible = false
	
	for child in get_children():
		child.visible = false
		child.queue_free()
	
	queue_free()
	
