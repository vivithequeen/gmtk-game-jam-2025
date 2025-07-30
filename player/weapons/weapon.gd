extends Node3D


@export var fire_rate : float = 0.2; #seconds between bullet
@export var bullet_type : PackedScene;
@export var mag_size : int = 3;
#@export var mag_type

var bullet;
var fire_timer = 0;

func _physics_process(delta: float) -> void:
	if(fire_timer>=0):
		fire_timer-=delta
	if(Input.is_action_pressed("fire") and fire_timer <= 0):
		fire_timer = fire_rate;
		var b := bullet_type.instantiate();
		
		b.spawn_rot = get_node("../../../../").global_rotation;
		b.spawn_pos = get_node("../../../../bullet_spawn").global_position;
		get_node("../../../../../../").add_child(b)
