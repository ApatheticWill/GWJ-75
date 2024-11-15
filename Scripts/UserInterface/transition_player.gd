extends Control
class_name TransitionPlayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	
	self.show()

func transition_in() -> void:
	
	self.show()
	animation_player.play("FadeIn")

func transition_out() -> void:
	
	animation_player.play("FadeOut")

func quick_transition() -> void:
	
	self.show()
	animation_player.play("QuickFade")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "FadeOut":
		self.hide()
	
	if anim_name == "QuickFade":
		self.hide()
	
	if anim_name == "FadeIn":
		self.show()
