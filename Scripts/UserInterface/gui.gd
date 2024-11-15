extends CanvasLayer
class_name GUI

@onready var transition_player: TransitionPlayer = $TransitionPlayer

func _ready() -> void:
	
	transition_player.hide()
