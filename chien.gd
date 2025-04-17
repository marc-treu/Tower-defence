extends CharacterBody2D

@export var speed = 0.1

func _process(delta):
	var ratio = get_parent().get_progress_ratio()
	ratio += delta * speed
	# ratio = ratio + delta * speed
	get_parent().set_progress_ratio(ratio)
	
	if ratio > 1:
		queue_free()
