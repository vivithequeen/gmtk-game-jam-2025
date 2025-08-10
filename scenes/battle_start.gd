extends Area3D



enum enemiesenum {
	GROUND_ENEMY,
	FLYING_ENEMY,
}
@onready var main := get_parent();

var activated = false;
var enemies_left : int = 0;
var enemy_scenes = [preload("res://enemies/enemy1.tscn"),preload("res://enemies/enemy2.tscn")]

@export var enemies : Array[enemiesenum]
@export var enemy_start : Array[Node3D]




func _on_body_entered(body:Node3D) -> void:


	if !activated and body.get("is_player"):

		enemies_left = enemies.size()
		get_tree().call_group("door", "close_door")
		activated = true;
		var index = 0;
		for i in enemies:

			var enemy = enemy_scenes[i].instantiate()
			enemy.start_pos = enemy_start[index].global_position
			enemy.player = main.player
			enemy.battle_starter = self
			main.add_child(enemy)
			index+=1;

func check_battle():
	print(enemies_left)
	if(enemies_left > 0):
		return 0;
	
	get_tree().call_group("door", "open_door")
	#queue_free()
