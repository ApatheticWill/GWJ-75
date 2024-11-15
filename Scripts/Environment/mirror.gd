extends RigidBody2D
class_name Mirror

@export var scene_resource : MirrorResource
@export var respawn_point : Vector2

@onready var highlight = preload("res://Assets/Environment/mirror_highlighted.png")
@onready var default = preload("res://Assets/Environment/mirror_base.png")
@onready var dark = preload("res://Assets/Environment/mirror_dark.png")
@onready var interactable : bool = false
@onready var is_interacted : bool = false
@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var interaction_zone: Area2D = $InteractionZone
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_reflection: Sprite2D = $PlayerReflection
@onready var collision_shape_2d: CollisionShape2D = $InteractionZone/CollisionShape2D

## Sound stuff
@onready var GameMusic = $"../../Music"  # Background music
@onready var PortalIn = $"../../PortalIn"  # Portal sound effect

func _ready() -> void:
	# Connect the `finished` signal of the portal sound to a function that changes the scene
	PortalIn.finished.connect(_on_portal_sound_finished)
	player_reflection.hide()

func _unhandled_key_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("interact") and interactable:
		player.gui.transition_player.transition_in()
		sprite_2d.texture = default
		player.can_move = false
		interactable = false
		is_interacted = true
		GameMusic.stop()  # Stop the main music
		PortalIn.play()  # Play the portal sound effect

		# The scene will change once the portal sound finishes (handled by `_on_portal_sound_finished`)

func _physics_process(_delta: float) -> void:
	
	if interactable:
		player_reflection.global_position = player.global_position
		player_reflection.global_position.x = player.global_position.x - 5
		player_reflection.flip_h = player.sprite_2d.flip_h
		player_reflection.show()
	elif is_interacted && !interactable:
		player_reflection.show()
	else:
		player_reflection.hide()

func _on_portal_sound_finished() -> void:
	# Set the respawn point and change the scene
	
	for body in interaction_zone.get_overlapping_bodies():
		GameManager.overworld_respawn_point = respawn_point
		body.get_tree().change_scene_to_file(scene_resource.scene_to_transition)

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		sprite_2d.texture = highlight
		interactable = true

func _on_interaction_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		sprite_2d.texture = default
		interactable = false
