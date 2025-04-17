extends CharacterBody2D

@export var speed = 0.1
@export var ratio = 0
var heath = 100

func rand_normal(mean: float = 0.1, stddev: float = 0.01) -> float:
	var u1 = randf()
	var u2 = randf()
	var z = sqrt(-2.0 * log(u1)) * cos(2.0 * PI * u2)
	return clamp(z * stddev + mean, 0.001, 5)

func _ready() -> void:
	self.speed = rand_normal()

func take_damage(damage):
	self.heath -= damage
	if self.heath <= 0:
		self.queue_free()

func _physics_process(delta):
	ratio = get_parent().get_progress_ratio()
	ratio += delta * speed
	# ratio = ratio + delta * speed
	get_parent().set_progress_ratio(ratio)
	
	if ratio > 1:
		queue_free()
