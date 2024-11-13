extends Control
class_name TutorialBox

@onready var info_text: RichTextLabel = $TutorialPanel/MarginContainer/InfoText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	Eventbus.change_tutorial_text.connect(on_tutorial_text_changed)

func on_tutorial_text_changed(text : String) -> void:
	
	info_text.text = text
	animation_player.play("Show")
	await get_tree().create_timer(3).timeout
	animation_player.play("Hide")
