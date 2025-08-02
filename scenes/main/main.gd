extends Node3D

var e1 = preload("res://enemies/enemy1.tscn")
var e2 = preload("res://enemies/enemy2.tscn")
@export var room_1_enemy_count: int = 3;
@export var room_2_enemy_count: int = 3;
@export var room_3_enemy_count: int = 3;
@export var room_4_enemy_count: int = 4;
@export var room_5_enemy_count: int = 8;
func _ready() -> void:
	$background_music.play()
	randomize()
	$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]
	$get_dash/Sprite3D.visible = !MapLoop.player_data["dash"]
	$WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0, 360))
	$bomb_pickup/Sprite3D.visible = !MapLoop.player_data["grenade"]
func _process(delta):
	$WorldEnvironment.environment.sky_rotation.z += delta / 80.0


func check_room_1():
	if (room_1_enemy_count > 0):
		return ;
	$battles.play("end_battle_1")
	MapLoop.battle_active = false
	battle_end()

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
	MapLoop.battle_active = true
	battle_start()
	$battles.play("start_battle_1")


func check_room_2():
	if (room_2_enemy_count > 0):
		return ;
	$battles.play("end_battle_2")
	MapLoop.battle_active = false
	battle_end()

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
	MapLoop.battle_active = true
	battle_start()
	$battles.play("start_battle_2")

func check_room_3():
	if (room_3_enemy_count > 0):
		return ;
	$battles.play("end_battle_3")
	MapLoop.battle_active = false
	battle_end()

func room_3_enemy_died():
	room_3_enemy_count -= 1;

func start_battle_3():
	var enemy1 = e1.instantiate();
	enemy1.start_pos = $battle3/enemy1.global_position
	enemy1.player = $Player
	enemy1.battle = 3;
	add_child(enemy1)
	

	var enemy2 = e1.instantiate();
	enemy2.start_pos = $battle3/enemy2.global_position
	enemy2.player = $Player
	enemy2.battle = 3;
	add_child(enemy2)

	var enemy3 = e1.instantiate();
	enemy3.start_pos = $battle3/enemy3.global_position
	enemy3.player = $Player
	enemy3.battle =3;
	add_child(enemy3)
	battle_start()
	$battles.play("start_battle_3")
	MapLoop.battle_active = true

func check_room_4():
	if (room_4_enemy_count > 0):
		return ;
	$battles.play("end_battle_4")
	MapLoop.battle_active = false
	battle_end()

func room_4_enemy_died():
	room_4_enemy_count -= 1;

func start_battle_4():
	var enemy1 = e2.instantiate();
	enemy1.start_pos = $battle4/enemy1.global_position
	enemy1.player = $Player
	enemy1.battle = 4;
	add_child(enemy1)
	

	var enemy2 = e2.instantiate();
	enemy2.start_pos = $battle4/enemy2.global_position
	enemy2.player = $Player
	enemy2.battle = 4;
	add_child(enemy2)

	var enemy3 = e1.instantiate();
	enemy3.start_pos = $battle4/enemy3.global_position
	enemy3.player = $Player
	enemy3.battle =4;
	add_child(enemy3)

	var enemy4 = e1.instantiate();
	enemy4.start_pos = $battle4/enemy4.global_position
	enemy4.player = $Player
	enemy4.battle = 4;
	add_child(enemy4)
	$battles.play("start_battle_4")
	battle_start()
	MapLoop.battle_active = true

func check_room_5():
	if (room_5_enemy_count > 0):
		return ;
	$battles.play("end_battle_5")
	MapLoop.battle_active = false
	battle_end()

func room_5_enemy_died():
	room_5_enemy_count -= 1;

func start_battle_5():
	var enemy1 = e2.instantiate();
	enemy1.start_pos = $battle5/enemy1.global_position
	enemy1.player = $Player
	enemy1.battle = 5;
	add_child(enemy1)
	

	var enemy2 = e2.instantiate();
	enemy2.start_pos = $battle5/enemy2.global_position
	enemy2.player = $Player
	enemy2.battle = 5;
	add_child(enemy2)

	var enemy3 = e1.instantiate();
	enemy3.start_pos = $battle5/enemy3.global_position
	enemy3.player = $Player
	enemy3.battle =5;
	add_child(enemy3)

	var enemy4 = e1.instantiate();
	enemy4.start_pos = $battle5/enemy4.global_position
	enemy4.player = $Player
	enemy4.battle = 5;
	add_child(enemy4)
	
	var enemy5 = e2.instantiate();
	enemy5.start_pos = $battle5/enemy5.global_position
	enemy5.player = $Player
	enemy5.battle = 5;
	add_child(enemy5)
	

	var enemy6 = e2.instantiate();
	enemy6.start_pos = $battle5/enemy6.global_position
	enemy6.player = $Player
	enemy6.battle = 5;
	add_child(enemy6)

	var enemy7 = e1.instantiate();
	enemy7.start_pos = $battle5/enemy7.global_position
	enemy7.player = $Player
	enemy7.battle =5;
	add_child(enemy7)

	var enemy8 = e1.instantiate();
	enemy8.start_pos = $battle5/enemy8.global_position
	enemy8.player = $Player
	enemy8.battle = 5;
	add_child(enemy8)
	$battles.play("start_battle_5")
	battle_start()
	MapLoop.battle_active = true
	
var area_switch_1_activated = false;
var area_switch_2_activated = false;

func _on_area_switch_2_body_entered(body: Node3D) -> void:
	if !area_switch_1_activated and body.get("id"):
		if body.get("id") == "player":
			area_switch_1_activated = true;
			MapLoop.player_data["heatlh"] = $Player.health
			MapLoop.player_data["dash_amount"] = $Player.dash_amount
			MapLoop.player_velocity = $Player.velocity
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
		if body.get("id") == "player" and !MapLoop.player_data["double_jump"]:
			double_jump_door_activated = true
			$battles.play("boot_pick_up")
			MapLoop.player_data["double_jump"] = true;
			$double_jump_upgrade/AudioStreamPlayer3D.play()
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
		$battles.play("dash_pick_up")
		if body.get("id") == "player" and !MapLoop.player_data["dash"]:

			get_dash_activated = true;
			
			$get_dash/AudioStreamPlayer3D.play()
			MapLoop.player_data["dash"] = true
			$get_dash/Sprite3D.visible = !MapLoop.player_data["dash"]

var dash_area_activated = false;

func _on_start_dash_path_body_entered(body:Node3D) -> void:
	if !dash_area_activated and body.get("id"):
		if body.get("id") == "player":
			dash_area_activated = true;

			$battles.play("dash_start")


func _on_end_check_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player" and MapLoop.end:
			MapLoop.end_pull = $end.global_position



func _on_end_final_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player":
			MapLoop.end = false
			print("hay")
			get_tree().change_scene_to_file("res://scenes/end/end_screen.tscn")


func _on_bomb_pickup_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player":
			
			MapLoop.player_data["grenade"] = true;
			$bomb_pickup/Sprite3D.visible = !MapLoop.player_data["grenade"]


func battle_start():
	$battle_music.play()
	$background_music.stop()


func battle_end():
	$battle_music.stop()
	$background_music.play()