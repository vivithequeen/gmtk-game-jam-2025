extends Control



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _on_again_pressed() -> void:
	get_tree().paused = false
	
	MapLoop.reset()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
