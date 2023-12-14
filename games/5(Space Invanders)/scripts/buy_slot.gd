extends Panel
class_name BuySlot

@onready var button: Button = $VBoxContainer/Button
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var spaceship: Spaceship = %Spaceship

@export var missle_resource: MissleResource
@export var cost = 40

func _ready() -> void:
	if(missle_resource != null):
		texture_rect.texture = missle_resource.texture
	button.text = "Buy " + str(cost) + "$"

func _on_button_button_down() -> void:
	spaceship.buy(missle_resource, cost, 1)
