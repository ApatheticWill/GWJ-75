extends StaticBody2D
class_name SealedDoor

@export_multiline var displayed_text : String

@onready var interactable : bool = false
@onready var collision_shape_2d: CollisionShape2D = $InteractionZone/CollisionShape2D
@onready var highlight := preload("res://Assets/Environment/door_highlighted.png")
@onready var default := preload("res://Assets/Environment/door_base.png")
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
	
	if GameManager.sealed_door_unlocked:
		call_deferred("queue_free")

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") && interactable:
		sprite_2d.texture = default
		collision_shape_2d.disabled = true
		Eventbus.text_to_display.emit(displayed_text, "", "")
		await get_tree().create_timer(3).timeout
		collision_shape_2d.disabled = false

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = true
	sprite_2d.texture = highlight


func _on_interaction_zone_body_exited(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interactable = false
	sprite_2d.texture = default
