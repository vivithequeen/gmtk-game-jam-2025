extends Node3D

const SPEED := 0.01;
var start
var direction : Vector3

var spawn_rot;
var spawn_pos;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("pp poo poo")
	global_position = spawn_pos;
	global_rotation = spawn_rot;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position+=direction*SPEED


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body:Node3D) -> void:
	if body.get("id"):
		if body.id == "player":
			body.health-=5;
			die()
	if body is StaticBody3D || body is CSGBox3D:
		die()

func die():
	#var i = load("res://scenes/bullet_hole.tscn").instantiate()
	#i.spawn_rot = Vector3.ZERO#global_rotation
	#i.spawn_pos = global_position
	#print(i)
	#get_parent().add_child(i)

	queue_free()