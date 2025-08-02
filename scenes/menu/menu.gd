extends Control


@export var other_button : Button;
enum {
	MAIN,
	SETTINGS,
	CONTROLS
}
func _ready() -> void:
	update()
var state = MAIN

func update():
	$controls.visible = state == CONTROLS
	$controls2.visible = state == MAIN
	$settings2.visible = state == SETTINGS
	$settings.visible = state == MAIN
	$quit.visible = state == MAIN
	other_button.visible = state == MAIN

func _on_back_pressed() -> void:
	state = MAIN
	update()



func _on_settings_pressed() -> void:
	state = SETTINGS
	update()


func _on_controls_2_pressed() -> void:
	state = CONTROLS
	update()


func _on_quit_pressed() -> void:
	get_tree().quit()
