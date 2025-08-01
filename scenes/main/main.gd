extends Node3D

var e1 = preload("res://enemies/enemy1.tscn")
var e2 = preload("res://enemies/enemy2.tscn")
@export var room_1_enemy_count: int = 3;
@export var room_2_enemy_count: int = 3;
func _ready() -> void:
	randomize()
	$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]
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

var area_switch_1_activated = false;
var area_switch_2_activated = false;


func _on_area_switch_2_body_entered(body: Node3D) -> void:
	if !area_switch_1_activated and body.get("id"):
		if body.get("id") == "player":
			area_switch_1_activated = true;


			MapLoop.player_data["current_gun"] = $Player.current_gun
			MapLoop.player_data["weapon1_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/pistol.ammo
			MapLoop.player_data["weapon2_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/shotgun.ammo
			MapLoop.player_data["weapon3_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/smg.ammo
			MapLoop.player_data["weapon4_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/rifle.ammo
			MapLoop.local_switch_pos = $Player.global_position - ($end_ancor.global_position - $start_ancor.global_position)
			MapLoop.local_switch_rotation = $Player.rotation + $Player/Camera3D.rotation
			get_tree().reload_current_scene()


func _on_area_switch_1_body_entered(body: Node3D) -> void:
	if !area_switch_2_activated and body.get("id"):
		if body.get("id") == "player":
			area_switch_2_activated = true;
			$battles.play("close_end_door")

var init_door_open_activated = false;


func _on_open_init_door_body_entered(body: Node3D) -> void:
	if !init_door_open_activated and body.get("id"):
		if body.get("id") == "player":
			init_door_open_activated = true;

			$battles.play("open_init_door")



var double_jump_door_activated = false;
func _on_double_jump_upgrade_body_entered(body: Node3D) -> void:
	if !double_jump_door_activated and body.get("id"):
		if body.get("id") == "player":
			double_jump_door_activated = true
			$battles.play("boot_pick_up")
			MapLoop.player_data["double_jump"] = true;
			$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]

var double_jump_start_activated = false;
func _on_start_double_jump_path_body_entered(body: Node3D) -> void:
	if !double_jump_start_activated and body.get("id"):
		if body.get("id") == "player":
			double_jump_start_activated = true
			$battles.play("double_jump_start")
			

var get_dash_activated = false;
func _on_get_dash_body_entered(body: Node3D) -> void:
	if !get_dash_activated and body.get("id"):
		if body.get("id") == "player":
			get_dash_activated = true;
			$battles.play("dash_pick_up")
			MapLoop.player_data["dash"] = true
