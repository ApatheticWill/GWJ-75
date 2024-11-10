extends Area2D

@export var move: bool
@export var x_start: int
@export var y_start: int

@export var x_final: int
@export var y_final: int

@export var seconds: float
var finished = false
var tween: Tween = null

func _ready():
	if move:
		position = Vector2(x_start, y_start)
		start_tween()

func _process(delta):
	pass

func start_tween():
	print("startTween called")
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	
	if not finished:
		tween.tween_property(self, "position", Vector2(x_final, y_final), seconds)
	else:
		tween.tween_property(self, "position", Vector2(x_start, y_start), seconds)
	
	finished = not finished
	tween.finished.connect(start_tween)
