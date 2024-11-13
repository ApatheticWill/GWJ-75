extends Control
class_name SettingsMenu


func _ready() -> void:
	
	hide()

func _on_return_button_pressed() -> void:
	
	Eventbus.hide_ui.emit()
