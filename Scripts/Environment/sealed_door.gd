extends StaticBody2D
class_name SealedDoor

@export_multiline var displayed_text : String

@onready var interactable : bool = false

func _physics_process(_delta: float) -> void:
	
	if GameManager.sealed_door_unlocked:
		call_deferred("queue_free")

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && interactable:
		Eventbus.text_to_display.emit(displayed_text, "", "")

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = true


func _on_interaction_zone_body_exited(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = false
