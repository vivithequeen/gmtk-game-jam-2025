extends Node3D


@export var fire_rate : float = 0.2; #seconds between bullet
@export var bullet_type : PackedScene;
@export var mag_size : int = 3;
@export var accuracy : float = 0;
#@export var mag_type
var is_reloading := false
var bullet;
var fire_timer = 0;

func _physics_process(delta: float) -> void:
	if(fire_timer>=0):
		fire_timer-=delta
	if(get_node("../../../../../").current_bullets>0 and !is_reloading):
		if(Input.is_action_pressed("fire") and fire_timer <= 0):
			$ani.play("fire")
			get_node("../../../../../").current_bullets-=1;
			fire_timer = fire_rate;
			var b := bullet_type.instantiate();
			b.accuracy = accuracy;
			b.spawn_rot = get_node("../../../../").global_rotation;
			b.spawn_pos = get_node("../../../../bullet_spawn").global_position;
			get_node("../../../../../../").add_child(b)
	else:
		if(!is_reloading):
			reload()

func reload():
	
	$ani.play("new_animation")
	$reload.start()
	is_reloading = true;

func _on_timer_timeout() -> void:
	is_reloading = false
	get_node("../../../../../").current_bullets = 24; #change hopefuly
