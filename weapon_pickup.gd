extends Area3D

@export var weapon : int ;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$spin.play("spin")

	get_node("Node3D/2").visible = weapon == 2
	get_node("Node3D/3").visible = weapon == 3
	get_node("Node3D/4").visible = weapon == 4




func _on_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.get("id") == "player":
			MapLoop.player_data["weapon" + str(weapon)] = true;
			queue_free()
