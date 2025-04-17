extends Node2D

@onready var path = preload("res://stage1.tscn")

func _on_timer_timeout() -> void:
	var tmpPath = path.instantiate()
	add_child(tmpPath)
