extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewportContainer/SubViewport/main_menu_background/WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0, 360))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$SubViewportContainer/SubViewport/main_menu_background/WorldEnvironment.environment.sky_rotation.z += delta / 80.0


func _on_play_pressed() -> void:
	MapLoop.reset()
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
