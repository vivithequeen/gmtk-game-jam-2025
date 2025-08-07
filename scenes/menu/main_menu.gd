extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$menu/music.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property($black, "modulate:a",0, 1)
	
	$SubViewportContainer/SubViewport/main_menu_background/WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0, 360))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$SubViewportContainer/SubViewport/main_menu_background/WorldEnvironment.environment.sky_rotation.z += delta / 80.0


func _on_play_pressed() -> void:
	$Timer.start()
	MapLoop.reset()
	MapLoop.menu_music_time = $menu/music.get_playback_position()

	$black.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($black, "modulate:a",1, 1)
	

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_timer_2_timeout() -> void:
	$black.visible = false
