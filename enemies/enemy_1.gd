extends Node3D

@export var movement_speed: float = 12.0
@export var battle: int = 1;
@export var player: CharacterBody3D
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
var bullet_type := preload("res://enemies/projectiles/enemy_bullet.tscn");
@export var health := 40;
var physics_delta: float

var attack_amounts = 0;
var attack_timer = 0;
var start_pos;

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	global_position = start_pos

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if (health <= 0):
		die()
	# Save the delta for use in _on_velocity_computed.
	physics_delta = delta
	var distance_from_player = (global_position - player.global_position).length()

	
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if (distance_from_player > 7.5):
		if navigation_agent.avoidance_enabled:
			_on_velocity_computed(new_velocity)
		else:
			_on_velocity_computed(new_velocity)
	else:
		attack_timer += delta;
		if (attack_timer >= 1):
			attack_amounts = 3;
			attack()
			attack_timer = 0;

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, physics_delta * movement_speed)

func _on_get_player_pos_timeout() -> void:
	set_movement_target(player.global_position);


func attack():
	for i in range(1):
		$attack.play()
		var b = bullet_type.instantiate();

		b.spawn_rot = global_rotation;
		b.spawn_pos = global_position;
		b.direction = (player.global_position - global_position).normalized()
		get_node("../").add_child(b)
		attack_amounts -= 1;
		if (attack_amounts > 0):
			$attack_offset.start()

func _on_attack_offset_timeout() -> void:
	attack()


func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.get("is_bullet"));
	if area.get("is_bullet"):
		health -= area.damage;
		print(health)
		$hit.play();

func die():
	get_parent().call("room_"+str(battle)+"_enemy_died");
	get_parent().call("check_room_"+str(battle));
	queue_free()
