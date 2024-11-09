extends Control
class_name MainMenu

func _on_start_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/Root/master.tscn")

func _on_settings_button_pressed() -> void:
	
	print("NOT IMPLEMENTED!")

func _on_quit_button_pressed() -> void:
	
	get_tree().quit()
