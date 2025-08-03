extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.grab_focus()
	$timer/minutes.text = ("0" if int(MapLoop.timer / 60) < 10 else "") + str(int(MapLoop.timer / 60))
	$timer/seconds.text = ("0" if int(int(MapLoop.timer) % 60) < 10 else "") + str(int(int(MapLoop.timer) % 60))
	$timer/miliseconds.text = ("0" if (int(int(MapLoop.timer * 60) % 60)) < 10 else "") + str(int(int(MapLoop.timer * 60) % 60))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
