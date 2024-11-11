extends Node2D

@export var lives: int
@export var remaining_points: int

func check_pass_level() -> bool:
	return remaining_points == 0

func life_lost():
	lives -= 1
	if lives == 0:
		reset_level()

func point_collected():
	remaining_points = max(0,remaining_points-1)
	

func reset_level():
	get_tree().reload_current_scene()

func level_completed():
	queue_free()
