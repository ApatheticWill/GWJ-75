extends Area2D
class_name PlayerReflection

@export var player: Player
@export var spawn_position : Vector2
@export var controller: Node


func _ready() -> void:
	
	self.global_position = spawn_position

func _physics_process(_delta):
	
	global_position = Vector2(player.global_position.x, -player.global_position.y)

func _on_area_entered(area: Area2D):
	
	if area.is_in_group("Mirror_Hazard"):
		
		Eventbus.reflection_died.emit()
	
	if area.is_in_group("Heart"):
		
		area.queue_free()
		Eventbus.heart_collected.emit()
