extends Node3D

var e1 = preload("res://enemies/enemy1.tscn")
var e2 = preload("res://enemies/enemy2.tscn")
var popup = preload("res://player/popup.tscn")

@export var player : CharacterBody3D

func _ready() -> void:
	
	$background_music.play(MapLoop.game_background_music_time)
	get_tree().call_group("audio", "update")

	randomize()
	
	$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]
	$get_dash/Sprite3D.visible = !MapLoop.player_data["dash"]
	$WorldEnvironment.environment.sky_rotation.z = deg_to_rad(randf_range(0, 360))
	$bomb_pickup/Sprite3D.visible = !MapLoop.player_data["grenade"]
func _process(delta):
	$WorldEnvironment.environment.sky_rotation.z += delta / 80.0

#
#func check_room_1():
#	if (room_1_enemy_count > 0):
#		return ;
#	$battles.play("end_battle_1")
#	MapLoop.battle_active = false
#	battle_end()

#func room_1_enemy_died():
#	room_1_enemy_count -= 1;
#
#func start_battle_1():
#	var enemy1 = e2.instantiate();
#	enemy1.start_pos = $battle1/enemy1.global_position
#	enemy1.player = $Player
#	enemy1.battle = 1;
#	add_child(enemy1)
#	
#
#	var enemy2 = e1.instantiate();
#	enemy2.start_pos = $battle1/enemy2.global_position
#	enemy2.player = $Player
#	enemy2.battle = 1;
#	add_child(enemy2)
#
#	var enemy3 = e1.instantiate();
#	enemy3.start_pos = $battle1/enemy3.global_position
#	enemy3.player = $Player
#	enemy3.battle = 1;
#	add_child(enemy3)
#	MapLoop.battle_active = true
#	battle_start()
#	$battles.play("start_battle_1")



var area_switch_1_activated = false;
var area_switch_2_activated = false;

func _on_area_switch_2_body_entered(body: Node3D) -> void:
	if !area_switch_1_activated and body.get("is_player"):
		area_switch_1_activated = true;
		MapLoop.game_background_music_time = $background_music.get_playback_position()
		MapLoop.player_data["heatlh"] = $Player.health
		MapLoop.player_data["dash_amount"] = $Player.dash_amount
		MapLoop.player_velocity = $Player.velocity
		MapLoop.player_data["current_gun"] = $Player.current_gun
		MapLoop.player_data["weapon1_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/guns/pistol.ammo
		MapLoop.player_data["weapon2_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/guns/shotgun.ammo
		MapLoop.player_data["weapon3_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/guns/smg.ammo
		MapLoop.player_data["weapon4_bullets"] = $Player/Camera3D/SubViewportContainer/SubViewport/Camera3D/guns/rifle.ammo
		MapLoop.local_switch_pos = $Player.global_position - ($level/end_ancor.global_position - $level/start_ancor.global_position)
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
			
			$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]
			if(Settings.settings["popups"]):
				
				var p = popup.instantiate()
				p.title = "double jump!!";
				p.main = "press [img]res://player/ui_icons/space.png[/img] or [img]res://player/ui_icons/a.png[/img] after jumping to double jump!!\nreach new heights with this ability!"
				body.get_node("Camera3D").add_child(p)
			else:
				$double_jump_upgrade/AudioStreamPlayer3D.play()

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
		if body.get("id") == "player":

			get_dash_activated = true;
			if(!MapLoop.player_data["dash"]):
				if(Settings.settings["popups"]):

					var p = popup.instantiate()
					p.title = "dash!!";
					p.main = "press [img]res://player/ui_icons/shift.png[/img] or [img]res://player/ui_icons/x.png[/img] to dash!!\nmake sure to watch your stamina!"
					body.get_node("Camera3D").add_child(p)
				else:

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
			$"TBLoader/Default Layer/entity_0_geometry".visible = false;
			$"TBLoader/tunnel/entity_1_geometry".visible = false;
			$"TBLoader/realtunnel/entity_2_geometry".visible = false;



func _on_end_final_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player":
			MapLoop.end = false
			print("hay")
			get_tree().change_scene_to_file("res://scenes/end/end_screen.tscn")


func _on_bomb_pickup_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player" and !MapLoop.player_data["grenade"]:
			if(Settings.settings["popups"]):

				var p = popup.instantiate()
				p.title = "bomb!!";
				p.main = "press [img]res://player/ui_icons/g.png[/img] or [img]res://player/ui_icons/y.png[/img] to throw a bomb!!\nlook for cracked surfaces!!"
				body.get_node("Camera3D").add_child(p)
			else:

				$bomb_pickup/AudioStreamPlayer3D.play()
			MapLoop.player_data["grenade"] = true;
			$bomb_pickup/Sprite3D.visible = !MapLoop.player_data["grenade"]


func battle_start():
	#var tween = get_tree().create_tween()
	
	$battle_music.play(MapLoop.game_battle_music_time)
	#$battle_music.volume_db = Settings.settings["music_db"] - 40
	#tween.tween_property($background_music,"volume_db",Settings.settings["music_db"]-40,1)
	#tween.parallel()
	
	#tween.tween_property($battle_music,"volume_db",Settings.settings["music_db"],1)
	
	MapLoop.game_background_music_time = $background_music.get_playback_position()
	$background_music.stop()
	


func battle_end():
	#var tween = get_tree().create_tween()
	#$background_music.volume_db = Settings.settings["music_db"] - 40
	#tween.tween_property($battle_music,"volume_db",Settings.settings["music_db"]-40,0.25)
	#tween.parallel()
	#
	#tween.tween_property($background_music,"volume_db",Settings.settings["music_db"],0.25)
	MapLoop.game_battle_music_time = $battle_music.get_playback_position()
	$battle_music.stop()
	$background_music.play(MapLoop.game_background_music_time)


func _on_background_music_finished() -> void:
	$background_music.play(0)


func _on_battle_music_finished() -> void:
	$battle_music.play(0)
