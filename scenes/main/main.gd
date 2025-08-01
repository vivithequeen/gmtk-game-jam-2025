extends Node3D

var e1 = preload("res://enemies/enemy1.tscn")
var e2 = preload("res://enemies/enemy2.tscn")
@export var room_1_enemy_count: int = 3;
@export var room_2_enemy_count: int = 3;
func _ready() -> void:
	$WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0, 360))
	
func _process(delta):
	$WorldEnvironment.environment.sky_rotation.z += delta / 80.0


func check_room_1():
	if (room_1_enemy_count > 0):
		return ;
	$battles.play("end_battle_1")

func room_1_enemy_died():
	room_1_enemy_count -= 1;

func start_battle_1():
	var enemy1 = e2.instantiate();
	enemy1.start_pos = $battle1/enemy1.global_position
	enemy1.player = $Player
	enemy1.battle = 1;
	add_child(enemy1)
	

	var enemy2 = e1.instantiate();
	enemy2.start_pos = $battle1/enemy2.global_position
	enemy2.player = $Player
	enemy2.battle = 1;
	add_child(enemy2)

	var enemy3 = e1.instantiate();
	enemy3.start_pos = $battle1/enemy3.global_position
	enemy3.player = $Player
	enemy3.battle = 1;
	add_child(enemy3)

	$battles.play("start_battle_1")


func check_room_2():
	if (room_2_enemy_count > 0):
		return ;
	$battles.play("end_battle_2")

func room_2_enemy_died():
	room_2_enemy_count -= 1;

func start_battle_2():
	var enemy1 = e2.instantiate();
	enemy1.start_pos = $battle1/enemy1.global_position
	enemy1.player = $Player
	enemy1.battle = 2;
	add_child(enemy1)
	

	var enemy2 = e2.instantiate();
	enemy2.start_pos = $battle2/enemy2.global_position
	enemy2.player = $Player
	enemy2.battle = 2;
	add_child(enemy2)

	var enemy3 = e2.instantiate();
	enemy3.start_pos = $battle2/enemy3.global_position
	enemy3.player = $Player
	enemy3.battle =2;
	add_child(enemy3)

	$battles.play("start_battle_2")
