extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var background: ColorRect = $Background


func show_text() -> void:
	
	background.show()
	await get_tree().create_timer(0.5).timeout
	animation_player.play("FadeIn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "FadeIn":
		await get_tree().create_timer(3).timeout
		animation_player.play("FadeOut")
	
	if anim_name == "FadeOut":
		
		get_tree().change_scene_to_file("res://Scenes/Root/master.tscn")
