extends RigidBody2D
class_name Mirror

@export var scene_to_transition : String # Copy the scenes path.

@onready var interactable : bool = false

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && interactable:
		GameManager.overworld_respawn_point = Vector2(570, 82)
		get_tree().change_scene_to_file(scene_to_transition)

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	
	if body is Player:
		interactable = true


func _on_interaction_zone_body_exited(body: Node2D) -> void:
	
	if body is Player:
		interactable = false
