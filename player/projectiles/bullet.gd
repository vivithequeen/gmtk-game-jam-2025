extends Area3D

var spawn_rot;
var spawn_pos;
var accuracy;
var is_bullet = true;
func _ready():
	print("i live...")
	$direction.position.x+=randf_range(-accuracy,accuracy);
	$direction.position.y+=randf_range(-accuracy,accuracy);

	global_position = spawn_pos;
	global_rotation = spawn_rot;
func _physics_process(delta: float) -> void:
	global_position += (global_position - $direction.global_position) * 8;

func _on_body_entered(body: Node3D) -> void:
	if body is StaticBody3D || body is CSGBox3D:
		die()


func _on_timer_timeout() -> void:
	die()


func die():
	#var i = load("res://scenes/bullet_hole.tscn").instantiate()
	#i.spawn_rot = Vector3.ZERO#global_rotation
	#i.spawn_pos = global_position
	#print(i)
	#get_parent().add_child(i)

	queue_free()
