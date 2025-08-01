extends Node3D


@export var fire_rate : float = 0.2; #seconds between bullet
@export var bullet_type : PackedScene;

@export var accuracy : float = 0;
@export var damage : float = 10;

@export var max_ammo : int = 24;
@export var amount_of_bullets : int = 1;
var ammo : int = max_ammo
#@export var mag_type
var is_reloading := false
var bullet;
var fire_timer = 0;


var is_current_weapon;
func _ready() -> void:
	ammo = max_ammo
func _physics_process(delta: float) -> void:
	if(is_current_weapon):
		if(fire_timer>=0):
			fire_timer-=delta
		if(ammo>0 and !is_reloading):
			if(Input.is_action_pressed("fire") and fire_timer <= 0):
				$ani.play("fire")
				ammo-=1;
				$fire.play();
				for i in range(amount_of_bullets):
					
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
	$reload2.play()
	$ani.play("new_animation")
	$reload.start()
	is_reloading = true;

func _on_timer_timeout() -> void:
	print("pp!!!")
	is_reloading = false
	ammo = max_ammo; #change hopefuly
