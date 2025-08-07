extends Control

var in_time : float = 1
var out_time : float = 1
var pause : float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = in_time * 2 + out_time * 2 + pause * 2
	$Timer.start()
	visible = true;
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer/godot, "modulate:a",1.0, in_time)
	tween.tween_interval(pause)
	tween.tween_property($CenterContainer/godot, "modulate:a",0, out_time)
	tween.tween_property($vivi, "modulate:a",1.0, in_time)
	tween.tween_interval(pause)
	tween.tween_property($vivi, "modulate:a",0, out_time)
	tween.tween_property(self, "modulate:a",0, out_time)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			quit()

	
func quit():
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_timer_timeout() -> void:
	quit()
