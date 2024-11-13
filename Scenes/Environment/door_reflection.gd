extends Area2D

@export var controller: master_reflection
@export var spawn_position : Vector2
@export var challenge_index : int
@onready var interactable : bool = false

## Sound stuff
@onready var MainMusic = $"../Music"
@onready var PortalOut = $"../PortalOut"

func _ready() -> void:
	Eventbus.heart_collected.connect(on_heart_collected)
	self.hide()

func on_heart_collected() -> void:
	if controller.check_pass_level():
		self.show()
		interactable = true

func _on_area_entered(_area):
	if !controller.check_pass_level():
		return
	MainMusic.stop()
	PortalOut.play()
	PortalOut.finished.connect(_on_portal_out_finished)
	Eventbus.challenge_beaten.emit(challenge_index)

func _on_portal_out_finished() -> void:
	# Change the scene after the portal sound is done
	get_tree().change_scene_to_file("res://Scenes/Root/master.tscn")
