extends Control
class_name PauseMenu

@onready var label: Label = $Label
@onready var button_container: VBoxContainer = $ButtonContainer
@onready var settings_menu: SettingsMenu = $SettingsMenu

func _ready() -> void:
	
	Eventbus.hide_ui.connect(on_ui_hidden)

func _on_resume_button_pressed() -> void:
	
	resume_game()


func _on_settings_button_pressed() -> void:
	
	settings_menu.show()
	label.hide()
	button_container.hide()


func _on_return_button_pressed() -> void:
	
	get_tree().paused = false
	GameManager.reset_progress()
	get_tree().change_scene_to_file("res://Scenes/UserInterface/main_menu.tscn")


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel") && get_tree().paused:
		resume_game()
		
	elif Input.is_action_just_pressed("ui_cancel") && !get_tree().paused:
		pause_game()

func resume_game() -> void:
	
	get_tree().paused = false
	hide()

func pause_game() -> void:
	
	get_tree().paused = true
	show()

func on_ui_hidden() -> void:
	
	settings_menu.hide()
	label.show()
	button_container.show()
