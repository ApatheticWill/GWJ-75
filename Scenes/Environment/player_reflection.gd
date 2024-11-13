extends Area2D
class_name PlayerReflection

@export var player: Player
@export var spawn_position : Vector2
@export var controller: master_reflection


func _ready() -> void:
	
	self.global_position = spawn_position

func _physics_process(_delta):
	
	global_position = Vector2(player.global_position.x, -player.global_position.y)

func _on_area_entered(area: Area2D):
	
	if area.is_in_group("enemies"):
		controller.life_lost()
		#Eventbus.reflection_died.emit()
	
	if area.is_in_group("Heart"):
		area.hide()
		area.collision_layer = 6
		controller.point_collected()
		Eventbus.heart_collected.emit()
