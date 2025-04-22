# Alternate setup with text instead of icons
extends CanvasLayer

@onready var gold_label = $MarginContainer/HBoxContainer/Gold/GoldLabel
@onready var health_label = $MarginContainer/HBoxContainer/Health/HealthLabel
@onready var player = get_node("../Player")  # Adjust path as needed

func _ready():
	if player:
		player.gold_changed.connect(_on_gold_changed)
		player.health_changed.connect(_on_health_changed)
		_on_gold_changed(player.gold)
		_on_health_changed(player.health)

func _on_gold_changed(new_amount):
	gold_label.text = "Gold: $ " + str(new_amount)
	
func _on_health_changed(new_amount):
	health_label.text = "Health: <3 " + str(new_amount)
