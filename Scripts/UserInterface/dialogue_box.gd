extends Control
class_name DialogueBox

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var read_rate : float = 0.03
@onready var text_tween : Tween
@onready var text_display : RichTextLabel = $TextBox/Label

func _ready() -> void:
	
	Eventbus.text_to_display.connect(on_text_to_display)
	
	hide_dialogue_box()

func _process(_delta: float) -> void:
	
	if text_tween != null:
		
		if text_tween.finished && text_display.visible_ratio == 1.0:
			player.can_move = true
			await get_tree().create_timer(1).timeout
			hide_dialogue_box()
	

func on_text_to_display(next_text : String) -> void:
	
	display_text(next_text)

func display_text(displayed_text : String) -> void:
	
	player.can_move = false
	text_tween = create_tween()
	text_display.text = displayed_text
	show_dialogue_box()
	text_tween.tween_property(text_display, "visible_ratio", 1.0, displayed_text.length() * read_rate)

func hide_dialogue_box() -> void:
	
	text_display.hide()
	text_display.visible_ratio = 0.0
	self.hide()

func show_dialogue_box() -> void:
	
	text_display.show()
	self.show()
