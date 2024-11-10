extends Camera2D

@onready var player : CharacterBody2D = $"../Player"
@export var lowerLimit: int 
@export var upperLimit: int 
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(clamp( lowerLimit, player.position.x,upperLimit),position.y)
	pass
