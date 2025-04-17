extends CharacterBody2D

@export var speed = 0.1
@export var ratio = 0
var heath = 100

func _ready() -> void:
	self.speed = 0.1 + randi_range(1, 10) / 200.0

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
