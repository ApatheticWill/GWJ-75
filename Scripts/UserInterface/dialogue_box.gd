extends Control
class_name DialogueBox

@onready var player : Player = get_tree().get_first_node_in_group("Player")
@onready var read_rate : float = 0.03
@onready var text_tween : Tween
@onready var text_display : RichTextLabel = $TextBox/Label
@onready var current_state := TextState.READY
@onready var text_queue := []

enum TextState{
	READY,
	READING,
	FINISHED
}

func _ready() -> void:
	
	Eventbus.text_to_display.connect(on_text_to_display)
	
	hide_dialogue_box()

func _process(_delta: float) -> void:
	
	match current_state:
		TextState.READY:
			if !text_queue.is_empty():
				player.can_move = false
				display_text()
			else:
				player.can_move = true
		TextState.READING:
			pass
		TextState.FINISHED:
			change_text_state(TextState.READY)
			hide_dialogue_box()
	
	
	if text_tween != null:
		
		if text_tween.finished && text_display.visible_ratio == 1.0:
			player.can_move = true
			await get_tree().create_timer(0.5).timeout
			change_text_state(TextState.FINISHED)

func on_text_to_display(first_text : String, second_text : String, third_text : String) -> void:
	
	if first_text != "":
		queue_text(first_text)
	if second_text != "":
		queue_text(second_text)
	if third_text != "":
		queue_text(third_text)

func queue_text(next_text : String) -> void:
	text_queue.push_back(next_text)

func display_text() -> void:
	
	var displayed_text = text_queue.pop_front()
	change_text_state(TextState.READING)
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

func change_text_state(next_state) -> void:
	current_state = next_state
