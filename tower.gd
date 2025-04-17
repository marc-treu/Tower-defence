extends CharacterBody2D


var targets = []
var cur_target = null
var damage: int = 10
var cool_down: int = 10
var cur_cool_down: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self:
		targets.append(body)
		

func get_target():
	var max_val = 0
	for target in targets:
		if target.ratio > max_val:
			max_val = target.ratio
			cur_target = target
	

func _physics_process(delta):
	if cur_cool_down == 0:
		get_target()
		if cur_target:
			cur_target.take_damage(damage)
			cur_cool_down = 10
	else:
		cur_cool_down -= 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	targets.erase(body)
