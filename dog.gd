extends CharacterBody2D

var DamageLabelScene = preload("res://damage_label.tscn")

var type: String = "ENEMY"
@export var speed = 0.1
@export var ratio = 0
var health = 100

func rand_normal(mean: float = 0.1, stddev: float = 0.01) -> float:
	var u1 = randf()
	var u2 = randf()
	var z = sqrt(-2.0 * log(u1)) * cos(2.0 * PI * u2)
	return clamp(z * stddev + mean, 0.001, 5)

func _ready() -> void:
	self.speed = rand_normal()

func take_damage(damage: int):
	self.health -= damage
	update_health_bar()
	show_damage_number(damage)
	if self.health <= 0:
		self.queue_free()

func show_damage_number(amount: int):
	var label = DamageLabelScene.instantiate()
	get_tree().current_scene.add_child(label)  # Add to root so it floats in screen space
	label.show_damage(amount, global_position)

func update_health_bar():
	var bar = $HealthBar
	bar.value = self.health

func _physics_process(delta):
	ratio = get_parent().get_progress_ratio()
	ratio += delta * speed
	# ratio = ratio + delta * speed
	get_parent().set_progress_ratio(ratio)
	
	if ratio > 1:
		queue_free()
