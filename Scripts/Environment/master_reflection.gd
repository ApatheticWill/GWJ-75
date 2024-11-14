extends Node
class_name master_reflection
@export var Maxlives: int
var lives: int
@export var points_to_collect: int
var remaining_points: int
@onready var player: Player = $Player
@onready var door_reflection: Area2D = $DoorReflection
@export var hearts: Array[Node2D] 
@export var player_spawn_location : Vector2 = Vector2(-198, -47)

func _ready() -> void:
	
	Eventbus.change_tutorial_text.emit("[center]Mind your footing...[/center]")
	Eventbus.reflection_died.connect(on_reflection_died)
	player.can_move = true
	remaining_points = points_to_collect
	lives = Maxlives
	player.global_position = player_spawn_location

func respawn_player() -> void:
	
	await get_tree().create_timer(0.1).timeout
	for item in hearts:
		item.show()
		item.collision_layer = 3
	remaining_points = points_to_collect
	lives = Maxlives
	player.global_position = player_spawn_location
	door_reflection.hide()

func on_reflection_died() -> void:
	
	respawn_player()
	
	


func check_pass_level() -> bool:
	return remaining_points == 0

func life_lost():
	lives = max(0,lives-1)
	if lives == 0:
		respawn_player()

func point_collected():
	printt("PointCollected: " , remaining_points)
	remaining_points = max(0,remaining_points-1)
	printt("PointCollected: " , remaining_points)
	

func reset_level():
	respawn_player()
