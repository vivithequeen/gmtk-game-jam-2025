extends Area3D

@export var weapon : int ;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$spin.play("spin")

	get_node("Node3D/2").visible = weapon == 2
	get_node("Node3D/3").visible = weapon == 3
	get_node("Node3D/4").visible = weapon == 4

var done = false;


var weapons = ["shotgun","smg","rifle"]
func _on_body_entered(body:Node3D) -> void:
	if body.get("id") and !done:
		if body.get("id") == "player":
			done = true;
			body.current_gun = weapons[weapon-2];
			body.update_weapons()
			get_node("Node3D/2").visible = false
			get_node("Node3D/3").visible = false
			get_node("Node3D/4").visible = false
			MapLoop.player_data["weapon" + str(weapon)] = true;
			$AudioStreamPlayer3D.play()


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
