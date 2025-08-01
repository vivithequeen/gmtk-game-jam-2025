extends Node3D

func _ready() -> void:
	$WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0,360))
	$AnimationPlayer.play("open_main_door")
func _process(delta):

	
	$WorldEnvironment.environment.sky_rotation.z+=delta /80.0
