extends Node

signal gold_changed(new_amount)
signal health_changed(new_amount)

@export var starting_gold = 100
@export var starting_health = 100

var gold = 0
var health = 0

func _ready():
	gold = starting_gold
	health = starting_health
	emit_signal("gold_changed", gold)
	emit_signal("health_changed", health)

func add_money(amount):
	gold += amount
	print("Player received " + str(amount) + " gold. Total: " + str(gold))
	emit_signal("gold_changed", gold)

func spend_money(amount):
	if can_afford(amount):
		gold -= amount
		emit_signal("gold_changed", gold)
		return true
	return false

func can_afford(amount):
	return gold >= amount

func take_damage(amount):
	health -= amount
	emit_signal("health_changed", health)
	
	# Check for game over
	if health <= 0:
		game_over()

func game_over():
	print("Game Over!")
	# You can implement game over logic here
	# Like showing a game over screen or restarting the level
	
func add_health(amount):
	health += amount
	emit_signal("health_changed", health)
