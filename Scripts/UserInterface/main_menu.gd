extends Control
class_name MainMenu

@onready var label: Label = $Label
@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_menu: SettingsMenu = $SettingsMenu
@onready var transition_player: TransitionPlayer = $TransitionPlayer
@onready var begin_text_background: Control = $BeginTextBackground
@onready var start_button: Button = $ButtonContainer/StartButton

func _ready() -> void:
	
	start_button.disabled = false
	button_container.show()
	begin_text_background.hide()
	Eventbus.hide_ui.connect(on_ui_hidden)
	transition_player.transition_out()
	

func _on_start_button_pressed() -> void:
	
	start_button.disabled = true
	button_container.hide()
	label.hide()
	transition_player.transition_in()
	await get_tree().create_timer(1.5).timeout
	begin_text_background.show()
	begin_text_background.show_text()

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
