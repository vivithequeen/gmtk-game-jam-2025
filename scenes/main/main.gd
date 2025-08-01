extends Node3D


@export var room_1_enemy_count : int = 2;
func _ready() -> void:
	$WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0,360))
	
func _process(delta):

	
	$WorldEnvironment.environment.sky_rotation.z+=delta /80.0


func check_room_1():
	if(room_1_enemy_count >0 ):
		return;
	$AnimationPlayer.play("open_main_door")

func room_1_enemy_died():
	room_1_enemy_count-=1;

func start_battle_1():
	