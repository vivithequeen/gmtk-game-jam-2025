extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var player: CharacterBody3D
var rot_num = 0;
@export var health := 80;
var battle_starter ; 

var bullet_type := preload("res://enemies/projectiles/enemy_bullet.tscn");
var attack_timer = 0;
var is_enemy = true
var start_pos;
func _ready():
	global_position = start_pos
	rot_num = deg_to_rad(randf_range(0, 360))


func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	if (health <= 0):
		die()
	velocity = ((player.global_position + Vector3(0, 0, 4).rotated(Vector3(0, 1, 0), rot_num)) - global_position) * SPEED

	velocity.y = ((player.global_position.y + 4) - global_position.y) * SPEED
	attack_timer += delta;
	if (attack_timer >= 2):
		attack()
		attack_timer = 0;
	move_and_slide()

func _on_change_position_timeout() -> void:
	rot_num = deg_to_rad(randf_range(0, 360))


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get("is_bullet"):
		health -= area.damage;
		$hit.play();

func die():
	battle_starter.enemies_left -=1;
	battle_starter.check_battle()
	queue_free()

func attack():
	for i in range(1):
		$attack.play()
		var a = bullet_type.instantiate();

		a.spawn_rot = global_rotation;
		a.spawn_pos = $start1.global_position;
		a.direction = (player.global_position - $start1.global_position).normalized()
		get_node("../").add_child(a)
		$attack.play()
		var b = bullet_type.instantiate();

		b.spawn_rot = global_rotation;
		b.spawn_pos = $start2.global_position;
		b.direction = (player.global_position - $start2.global_position).normalized()
		get_node("../").add_child(b)
