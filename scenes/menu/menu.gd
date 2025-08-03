extends Control


@export var other_button : Button;
enum {
	MAIN,
	SETTINGS,
	CONTROLS,
	CREDITS
}
func _ready() -> void:
	$settings2/popups.button_pressed = Settings.popups 
	$settings2/timer.button_pressed = Settings.timer_active 
	$settings2/fullscreen.button_pressed = Settings.fullscreen   
	$settings2/volumn_slider.value = ((Settings.volumn_db+24)/4.0) * 4.0
	$settings2/look_sense_slider.value = Settings.look_sense
	get_tree().call_group("audio", "update")

	update()
	

var state = MAIN



func update():
	$controls.visible = state == CONTROLS
	$controls2.visible = state == MAIN
	$settings2.visible = state == SETTINGS
	$settings.visible = state == MAIN
	$quit.visible = state == MAIN
	$credits.visible = state == MAIN
	other_button.visible = state == MAIN
	$credits2.visible = state == CREDITS

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






func _on_credits_pressed() -> void:
	state = CREDITS
	$select.play()
	update()


func _on_music_finished() -> void:
	$music.play(0)


func _on_volumn_slider_value_changed(value: float) -> void:
	$settings2/vol.text = str(int($settings2/volumn_slider.value))
	Settings.volumn_db =($settings2/volumn_slider.value/4) - 24
	get_tree().call_group("audio", "update")
	$tick.play()


func _on_look_sense_slider_value_changed(value: float) -> void:
	$settings2/sense.text = str(int($settings2/look_sense_slider.value))
	Settings.look_sense =$settings2/look_sense_slider.value

	$tick.play()


func _on_popups_pressed() -> void:
	Settings.popups = $settings2/popups.button_pressed
