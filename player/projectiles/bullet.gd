extends Area3D

var spawn_rot;
var spawn_pos;

func _ready():
	global_position = spawn_pos;
	global_rotation = spawn_rot;
func _physics_process(delta: float) -> void:
	global_position+=(global_position - $direction.global_position) * 8;

func _on_body_entered(body:Node3D) -> void:
	if body is StaticBody3D || body is CSGBox3D:
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
