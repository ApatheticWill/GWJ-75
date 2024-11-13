extends Node
class_name Master

@onready var tutorial_door: LockedDoor = $LockedDoors/TutorialDoor
@onready var tutorial_mirror: Mirror = $Mirrors/TutorialMirror
@onready var first_challenge_door: LockedDoor = $LockedDoors/FirstChallengeDoor
@onready var second_challenge_door: LockedDoor = $LockedDoors/SecondChallengeDoor
@onready var third_challenge_door: LockedDoor = $LockedDoors/ThirdChallengeDoor
@onready var player: Player = $Player

func _ready() -> void:
	
	player.global_position = GameManager.overworld_respawn_point
	player.camera.enabled = true
	check_for_progress()

func check_for_progress() -> void:
	
	if GameManager.tutorial_beaten:
		tutorial_mirror.call_deferred("queue_free")
		tutorial_door.call_deferred("queue_free")
	
	if GameManager.first_challenge_beaten:
		# Will Have Mirror.
		first_challenge_door.call_deferred("queue_free")
	
	if GameManager.second_challenge_beaten:
		# Will Have Mirror.
		second_challenge_door.call_deferred("queue_free")
	
	if GameManager.third_challenge_beaten:
		# Will Have Mirror.
		third_challenge_door.call_deferred("queue_free")
