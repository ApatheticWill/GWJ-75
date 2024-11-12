extends Area2D

@export var controller: master_reflection
@export var spawn_position : Vector2
@export var challenge_index : int
@onready var interactable : bool = false

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
	
	Eventbus.challenge_beaten.emit(challenge_index)
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scenes/Root/master.tscn")
