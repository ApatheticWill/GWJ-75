extends Node
class_name TutorialMirrorWorld

@onready var player: Player = $Player
@onready var door_reflection: Area2D = $DoorReflection
@onready var player_spawn_location : Vector2 = Vector2(-198, -47)

func _ready() -> void:
	
	Eventbus.reflection_died.connect(on_reflection_died)
	
	player.camera.enabled = false
	player.global_position = player_spawn_location

func respawn_player() -> void:
	
	await get_tree().create_timer(0.2).timeout
	player.global_position = player_spawn_location

func on_reflection_died() -> void:
	
	respawn_player()
	door_reflection.interactable = false
	door_reflection.hide()
