extends RigidBody2D
class_name TextTablet

@export_multiline var first_displayed_text : String
@export_multiline var second_displayed_text : String
@export_multiline var informative_text : String

@onready var interactable : bool = false
@onready var collision_shape_2d: CollisionShape2D = $InteractionZone/CollisionShape2D


func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && interactable:
		collision_shape_2d.disabled = true
		Eventbus.text_to_display.emit(first_displayed_text, informative_text, "")
		GameManager.sealed_door_unlocked = true
		await get_tree().create_timer(5).timeout
		queue_free()

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = true


func _on_interaction_zone_body_exited(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = false
