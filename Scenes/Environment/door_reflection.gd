extends Area2D

@export var controller: Node2D
@export var  NextLevel : PackedScene
@onready var label : Label = $Label

func _on_area_entered(_area):
	if controller.remaining_points == 0:
		controller.level_completed
		print("WIN")
		#logic to next level
		return
	else :
		label.visible = true		
		return
		


func _on_area_exited(_area):
	label.visible = false		
	pass 
