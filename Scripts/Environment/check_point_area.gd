extends Area2D
class_name CheckPointArea

@export var checkpoint_coords : Vector2

func _on_body_entered(body: Node2D) -> void:
	
	if body is Player:
		GameManager.overworld_respawn_point = checkpoint_coords
