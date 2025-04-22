extends CharacterBody2D

signal enemy_killed(reward)  # Add this signal
signal enemy_strike(attack_power)  # Add this signal

var DamageLabelScene = preload("res://damage_label.tscn")

var type: String = "ENEMY"
@export var speed = 0.1
@export var ratio = 0
var health = 100
@export var gold_reward = 10  # Add gold reward amount
@export var attack_power = 10  # Add gold reward amount
var path_follow = null


func rand_normal(mean: float = 0.1, stddev: float = 0.01) -> float:
	var u1 = randf()
	var u2 = randf()
	var z = sqrt(-2.0 * log(u1)) * cos(2.0 * PI * u2)
	return clamp(z * stddev + mean, 0.001, 5)

func _ready() -> void:
	path_follow = get_parent()
	self.speed = rand_normal()

func take_damage(damage: int):
	self.health -= damage
	update_health_bar()
	show_damage_number(damage)
	if self.health <= 0:
		enemy_killed.emit(gold_reward)  # Emit signal when killed
		self.queue_free()

func show_damage_number(amount: int):
	var label = DamageLabelScene.instantiate()
	get_tree().current_scene.add_child(label)  # Add to root so it floats in screen space
	label.show_damage(amount, global_position)

func update_health_bar():
	var bar = $HealthBar
	bar.value = self.health

func _physics_process(delta):
	ratio = path_follow.get_progress_ratio()
	ratio += delta * speed
	path_follow.set_progress_ratio(ratio)

	if ratio > 1:
		enemy_strike.emit(attack_power)  # Emit signal when killed
		queue_free()
