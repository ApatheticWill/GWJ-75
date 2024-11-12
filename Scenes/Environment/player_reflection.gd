extends Area2D

@export var player: Node2D
@export var controller: Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = Vector2(player.position.x, -player.position.y)

func _on_area_entered(area: Area2D):
	if area.is_in_group("enemies"):
		controller.life_lost()
		area.queue_free()
	
	if area.is_in_group("points"):
		controller.point_collected()
		area.queue_free()
