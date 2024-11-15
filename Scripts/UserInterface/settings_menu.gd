extends Control
class_name SettingsMenu

@onready var master_bus_index : int
@onready var music_bus_index : int
@onready var sfx_bus_index : int
@onready var h_slider: HSlider = $SettingsBar/Sliders/HSlider
@onready var h_slider_2: HSlider = $SettingsBar/Sliders/HSlider2
@onready var h_slider_3: HSlider = $SettingsBar/Sliders/HSlider3

func _ready() -> void:
	
	hide()
	master_bus_index = AudioServer.get_bus_index("Master")
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFXEnv")
	h_slider.value = GameManager.master_volume_value * 100
	h_slider_2.value = GameManager.music_volume_value * 100
	h_slider_3.value = GameManager.sfx_volume_value * 100

func _on_return_button_pressed() -> void:
	
	Eventbus.hide_ui.emit()

func _on_h_slider_value_changed(value: float) -> void:
	
	AudioServer.set_bus_volume_db(
		master_bus_index,
		linear_to_db(value/100)
	)
	
	GameManager.master_volume_value = value / 100


func _on_h_slider_2_value_changed(value: float) -> void:
	
	AudioServer.set_bus_volume_db(
		music_bus_index,
		linear_to_db(value/100)
	)
	
	GameManager.music_volume_value = value / 100

func _on_h_slider_3_value_changed(value: float) -> void:
	
	AudioServer.set_bus_volume_db(
		sfx_bus_index,
		linear_to_db(value/100)
	)
	
	GameManager.sfx_volume_value = value / 100
