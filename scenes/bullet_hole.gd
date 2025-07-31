extends Decal
var spawn_rot;
var spawn_pos;

func _ready():
	print(spawn_pos)
	global_position = spawn_pos;
	global_rotation = spawn_rot;



func _on_timer_timeout() -> void:
	queue_free()
