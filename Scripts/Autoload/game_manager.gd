extends Node

var overworld_respawn_point : Vector2 = Vector2(-350, -75)
var mirrorworld_respawn_point_tutorial : Vector2
var mirrorworld_respawn_point_1 : Vector2
var mirrorworld_respawn_point_2 : Vector2
var mirrorworld_respawn_point_3 : Vector2
var sealed_door_unlocked : bool = false
var tutorial_beaten : bool = false
var first_challenge_beaten : bool = false
var second_challenge_beaten : bool = false
var third_challenge_beaten : bool = false

func _ready() -> void:
	
	Eventbus.challenge_beaten.connect(on_challenge_beaten)

func on_challenge_beaten(index : int) -> void:
	
	if index == 1:
		
		tutorial_beaten = true
	
	elif index == 2:
		
		first_challenge_beaten = true
	
	elif index == 3:
		
		second_challenge_beaten = true
		
	elif index == 4:
		
		third_challenge_beaten = true
