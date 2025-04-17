extends CharacterBody2D


var targets = []

func _on_area_2d_body_entered(body: Node2D) -> void:
	targets = get_node("col").get_overlapping_bodies()
	if targets:
		
		for target in targets:
			if "chien" in target.name:
				target.queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
