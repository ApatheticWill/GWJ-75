extends RigidBody2D
class_name Mirror

@export var scene_resource : MirrorResource
@export var respawn_point : Vector2

@onready var interactable : bool = false
@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var interaction_zone: Area2D = $InteractionZone

## Sound stuff
@onready var GameMusic = $"../../Music"  # Background music
@onready var PortalIn = $"../../PortalIn"  # Portal sound effect

func _ready() -> void:
	# Connect the `finished` signal of the portal sound to a function that changes the scene
	PortalIn.finished.connect(_on_portal_sound_finished)

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") and interactable:
		player.can_move = false
		interactable = false
		GameMusic.stop()  # Stop the main music
		PortalIn.play()  # Play the portal sound effect

		# The scene will change once the portal sound finishes (handled by `_on_portal_sound_finished`)

func _on_portal_sound_finished() -> void:
	# Set the respawn point and change the scene
	
	for body in interaction_zone.get_overlapping_bodies():
		GameManager.overworld_respawn_point = respawn_point
		body.get_tree().change_scene_to_file(scene_resource.scene_to_transition)

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		interactable = true

func _on_interaction_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		interactable = false