extends Node

@onready var path = get_parent().get_node("Path2D")
# @onready var path = get_parent().get_node("Player")
@onready var EnemyScene = preload("res://dog.tscn")
@onready var timer = $Timer

func _ready():
	timer.start()  # Start the timer to auto-spawn enemies

func spawn_enemy():
	var enemy = EnemyScene.instantiate()
	var follow = PathFollow2D.new()
	path.add_child(follow)
	follow.add_child(enemy)
	enemy.scale = Vector2(-2.0, -2.0)
	
	# Connect the enemy_killed signal if it exists
	# if enemy.has_signal("enemy_killed"):
	# 	enemy.enemy_killed.connect(player.add_money)

func _on_timer_timeout() -> void:
	spawn_enemy()
