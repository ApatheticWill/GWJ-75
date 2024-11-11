extends Area2D

@export var controller: Node2D
@export var  NextLevel : PackedScene
@onready var label : Label = $Label

func _on_area_entered(area):
	if controller.remaining_points == 0:
		#logic to next level
		return
	else :
		label.visible = true		
		return
		
	pass 


func _on_area_exited(area):
	label.visible = false		
	pass # Replace with function body.
