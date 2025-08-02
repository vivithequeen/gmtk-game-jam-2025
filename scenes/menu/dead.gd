extends Control




func _on_again_pressed() -> void:
	get_tree().paused = false
	MapLoop.reset()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
