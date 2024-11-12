extends StaticBody2D
class_name LockedDoor

@export_multiline var displayed_text : String

@onready var can_interact : bool = false

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && can_interact:
		Eventbus.text_to_display.emit(displayed_text, "", "")

func _on_interaction_area_body_entered(body: Node2D) -> void:
	
	if body is Player:
		can_interact = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	
	if body is Player:
		can_interact = false
