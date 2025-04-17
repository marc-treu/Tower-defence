extends Label

@export var float_distance: float = 30.0
@export var float_duration: float = 0.5

func show_damage(amount: int, position: Vector2):
	text = str(amount)
	global_position = position
	modulate = Color(1, 0, 0, 1)  # fully visible
	visible = true

	# Animate float
	var tween = create_tween()
	tween.tween_property(self, "position", position - Vector2(0, float_distance), float_duration)
	tween.tween_property(self, "modulate:a", 0.0, float_duration).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(self.queue_free)
