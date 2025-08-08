extends Control


@export var other_button : Button;

enum {
	MAIN,
	SETTINGS,
	CONTROLS,
	CREDITS,
	QUIT
}
func _ready() -> void:
	Settings.load_game()
	other_button.grab_focus()
	update_ui()
	

	update()

func update_ui():

	$settings2/TabContainer/Game/popups.button_pressed = Settings.settings["popups"] 
	$settings2/TabContainer/Game/timer.button_pressed = Settings.settings["timer_active"] 


	$settings2/TabContainer/Audio/master.value = db_to_linear(Settings.settings["master_db"])*100
	$settings2/TabContainer/Audio/music.value = db_to_linear(Settings.settings["music_db"])*100
	$settings2/TabContainer/Audio/sfx.value = db_to_linear(Settings.settings["sfx_db"])*100

	$settings2/TabContainer/Game/look_sense_slider.value = Settings.settings["look_sense"]
	$settings2/TabContainer/Game/fov.value = Settings.settings["fov"]
	$settings2/TabContainer/Window/fullscreen.button_pressed = Settings.settings["fullscreen"]
	$settings2/TabContainer/Window/vsync.button_pressed = Settings.settings["vsync"]


var state = MAIN
func _physics_process(_delta: float) -> void:
	if(state == CONTROLS):
		if(state == CONTROLS and Input.is_action_pressed("scroll_down")):
			$controls/VScrollBar.scroll_vertical+=1;
		if(Input.is_action_pressed("scroll_up")):
			$controls/VScrollBar.scroll_vertical-=1;



func update():
	$controls.visible = state == CONTROLS
	$controls2.visible = state == MAIN
	$settings2.visible = state == SETTINGS
	$settings.visible = state == MAIN
	$quit.visible = state == MAIN
	$credits.visible = state == MAIN
	other_button.visible = state == MAIN
	$credits2.visible = state == CREDITS
	$quit2.visible = state == QUIT

func _on_back_pressed() -> void:
	$select.play()
	state = MAIN
	other_button.grab_focus()
	update()



func _on_settings_pressed() -> void:

	$settings2/TabContainer/Game/timer.grab_focus()
	state = SETTINGS
	$select.play()
	update()


func _on_controls_2_pressed() -> void:
	state = CONTROLS
	#$controls/back.grab_focus()
	$select.play()
	update()


func _on_quit_pressed() -> void:
	state = QUIT
	$quit2/yes.grab_focus()
	update()


func _on_fullscreen_pressed() -> void:
	$select.play()
	Settings.settings["fullscreen"] = $settings2/TabContainer/Window/fullscreen.button_pressed
	Settings.toggle_fullscreen()


func _on_timer_pressed() -> void:
	$select.play()
	Settings.settings["timer_active"] = $settings2/TabContainer/Game/timer.button_pressed






func _on_credits_pressed() -> void:
	state = CREDITS
	$credits2/back.grab_focus()
	$select.play()
	update()


func _on_music_finished() -> void:
	$music.play(0)


func _on_volumn_slider_value_changed(value: float) -> void:
	$settings2/TabContainer/Audio/vol.text = str(int($settings2/TabContainer/Audio/master.value))
	Settings.settings["master_db"] = linear_to_db($settings2/TabContainer/Audio/master.value/100.0)
	get_tree().call_group("audio", "update")
	if($settings2/TabContainer/Audio/master.value != db_to_linear(Settings.settings["master_db"])*100):
		$tick.play()


func _on_look_sense_slider_value_changed(value: float) -> void:
	$settings2/TabContainer/Game/sense.text = str(int($settings2/TabContainer/Game/look_sense_slider.value))
	Settings.settings["look_sense"] =$settings2/TabContainer/Game/look_sense_slider.value
	if($settings2/TabContainer/Game/look_sense_slider.value != Settings.settings["look_sense"]):
		$tick.play()


func _on_popups_pressed() -> void:
	Settings.settings["popups"] = $settings2/TabContainer/Game/popups.button_pressed


func _on_no_pressed() -> void:
	state = MAIN
	other_button.grab_focus()
	$select.play()
	update()


func _on_yes_pressed() -> void:
	get_tree().quit()


func _on_save_pressed() -> void:
	Settings.save_game()


func _on_sfx_slider_value_changed(value:float) -> void:

	$settings2/TabContainer/Audio/vol3.text = str(int($settings2/TabContainer/Audio/sfx.value))
	Settings.settings["sfx_db"] = linear_to_db($settings2/TabContainer/Audio/sfx.value/100.0)
	get_tree().call_group("audio", "update")
	if($settings2/TabContainer/Audio/sfx.value != db_to_linear(Settings.settings["sfx_db"])*100):
		$tick.play()



func _on_music_value_changed(value:float) -> void:
	$settings2/TabContainer/Audio/vol2.text = str(int($settings2/TabContainer/Audio/music.value))
	Settings.settings["music_db"] = linear_to_db($settings2/TabContainer/Audio/music.value/100.0)
	get_tree().call_group("audio", "update")
	if($settings2/TabContainer/Audio/music.value != db_to_linear(Settings.settings["music_db"])*100):
		$tick.play()


func _on_vsync_pressed() -> void:
	$select.play()
	Settings.settings["vsync"] = $settings2/TabContainer/Window/vsync.button_pressed
	Settings.update_vsync()


func _on_fov_value_changed(value: float) -> void:
	$settings2/TabContainer/Game/fov2.text = str(int($settings2/TabContainer/Game/fov.value))
	Settings.settings["fov"] =$settings2/TabContainer/Game/fov.value
	if($settings2/TabContainer/Game/fov.value != Settings.settings["fov"]):
		$tick.play()




func _on_reset_pressed() -> void:
	Settings.settings = Settings.settings_default
	update_ui()
	update()
