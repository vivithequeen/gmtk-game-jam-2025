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
	$select.play()
	state = MAIN
	update()



func _on_settings_pressed() -> void:
	state = SETTINGS
	$select.play()
	update()


func _on_controls_2_pressed() -> void:
	state = CONTROLS
	$select.play()
	update()


func _on_quit_pressed() -> void:
	
	get_tree().quit()


func _on_fullscreen_pressed() -> void:
	$select.play()
	Settings.fullscreen = $settings2/fullscreen.button_pressed
	Settings.toggle_fullscreen()


func _on_timer_pressed() -> void:
	$select.play()
	Settings.timer_active = $settings2/timer.button_pressed


func _on_look_sense_slider_drag_ended(value_changed: bool) -> void:
	pass # Replace with function body.


func _on_volumn_slider_drag_ended(value_changed: bool) -> void:
	pass # Replace with function body.
