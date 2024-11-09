extends StaticBody2D
class_name LockedDoor

@onready var can_interact : bool = false
@onready var is_locked : bool = true

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && can_interact && is_locked:
		Eventbus.text_to_display.emit("To proceed, one must face their darkest parts.")
	elif event.is_action_pressed("interact") && can_interact && !is_locked:
		self.queue_free()

func _on_interaction_area_body_entered(body: Node2D) -> void:
	
	if body is Player:
		can_interact = true
		


func _on_interaction_area_body_exited(body: Node2D) -> void:
	
	if body is Player:
		can_interact = false
