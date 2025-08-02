extends Area3D
var spawn_rot;
var spawn_pos;
var items = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_pos;
	global_rotation = spawn_rot;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += (global_position - $direction.global_position) * 1;


func _on_body_entered(body:Node3D) -> void:
	items.append(body)

var dead = false;
func _on_hit_body_entered(body:Node3D) -> void:
	if (body is StaticBody3D || body is CSGBox3D )and !dead:
		dead = true
		$AudioStreamPlayer3D.play()
		for i in items:
			if(is_instance_valid(i)):
				if(i.get("is_enemy")):
					i.health-=40
				elif(i.name == "breakable"):
					i.get_parent().queue_free()
				
		$Sprite3D.visible = false;
		


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
