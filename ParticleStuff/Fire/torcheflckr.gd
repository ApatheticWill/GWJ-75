extends Light2D

@export var min_intensity: float = 0.8
@export var max_intensity: float = 1.2
@export var min_flicker_speed: float = 0.08
@export var max_flicker_speed: float = 0.17


var flicker_timer: float = 0.0

func _process(delta: float) -> void:
	flicker_timer -= delta
	if flicker_timer <= 0.0:
		energy = randf_range(min_intensity, max_intensity)
		color = Color(1.0, randf_range(0.8, 1.0), randf_range(0.4, 0.6), 1.0)
		
		flicker_timer = randf_range(min_flicker_speed, max_flicker_speed)
