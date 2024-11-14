extends Node
class_name Master

@onready var tutorial_door: LockedDoor = $LockedDoors/TutorialDoor
@onready var tutorial_mirror: Mirror = $Mirrors/TutorialMirror
@onready var first_challenge_door: LockedDoor = $LockedDoors/FirstChallengeDoor
@onready var challenge_mirror_1: Mirror = $Mirrors/ChallengeMirror1
@onready var second_challenge_door: LockedDoor = $LockedDoors/SecondChallengeDoor
@onready var challenge_mirror_2: Mirror = $Mirrors/ChallengeMirror2
@onready var third_challenge_door: LockedDoor = $LockedDoors/ThirdChallengeDoor
@onready var challenge_mirror_3: Mirror = $Mirrors/ChallengeMirror3
@onready var final_door: LockedDoor = $LockedDoors/FinalDoor
@onready var player: Player = $Player
@onready var jump_info_area: Area2D = $InfoAreas/JumpInfoArea
@onready var interact_info_area: Area2D = $InfoAreas/InteractInfoArea

func _ready() -> void:
	
	player.global_position = GameManager.overworld_respawn_point
	player.camera.enabled = true
	player.can_move = true
	check_for_progress()

func check_for_progress() -> void:
	
	if GameManager.tutorial_beaten:
		tutorial_mirror.call_deferred("queue_free")
		tutorial_door.call_deferred("queue_free")
	else:
		Eventbus.change_tutorial_text.emit("[center][WASD] To Move![/center]")
	
	if GameManager.first_challenge_beaten:
		challenge_mirror_1.call_deferred("queue_free")
		first_challenge_door.call_deferred("queue_free")
	
	if GameManager.second_challenge_beaten:
		challenge_mirror_2.call_deferred("queue_free")
		second_challenge_door.call_deferred("queue_free")
	
	if GameManager.third_challenge_beaten:
		challenge_mirror_3.call_deferred("queue_free")
		third_challenge_door.call_deferred("queue_free")

	if GameManager.challenges_beaten:
		final_door.call_deferred("queue_free")

func _on_jump_info_area_body_entered(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	jump_info_area.call_deferred("queue_free")
	Eventbus.change_tutorial_text.emit("[center][SPACE] To Jump![/center]")
	

func _on_interact_info_area_body_entered(body: Node2D) -> void:
	
	if !body is Player:
		return
	
	interact_info_area.call_deferred("queue_free")
	Eventbus.change_tutorial_text.emit("[center][E] To Interact![/center]")
	
