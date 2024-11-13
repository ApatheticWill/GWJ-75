extends Control
class_name MainMenu

@onready var label: Label = $Label
@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_menu: SettingsMenu = $SettingsMenu

func _ready() -> void:
	
	Eventbus.hide_ui.connect(on_ui_hidden)

func _on_start_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/Root/master.tscn")

func _on_settings_button_pressed() -> void:
	
	settings_menu.show()
	label.hide()
	button_container.hide()

func _on_quit_button_pressed() -> void:
	
	get_tree().quit()

func on_ui_hidden() -> void:
	
	settings_menu.hide()
	label.show()
	button_container.show()
