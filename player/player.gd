extends CharacterBody3D


const SPEED = 9.0
const JUMP_VELOCITY = 6.0;
const LOOK_SENSE = 0.0025;

var controller_look_sense = 0.07;

@onready var camera = $Camera3D

var health = 100;
var id = "player"
#WEAPONS


#headbob
var headbob_timer = 0;
var headbob_speed = 6;
var headbob_distance = 0.4;

var paused := false;

var can_double_jump := false;

#dash
var dash_timer := 0.0;
var dash_amount := 0.15;
var dash_speed := 40.0;
var dash_direction: Vector2
var is_dashing := false;
var is_crouching = false
var dashs = 3;

@onready var pause_timer: Timer = $can_pause

var can_pause = true
var current_gun = "pistol"

func _ready() -> void:
	update_mouse_mode()
	
	
	if (!MapLoop.init_run):
		velocity = MapLoop.player_velocity
		current_gun = MapLoop.player_data["current_gun"]
		$Camera3D/SubViewportContainer/SubViewport/Camera3D/pistol.ammo = MapLoop.player_data["weapon1_bullets"]
		$Camera3D/SubViewportContainer/SubViewport/Camera3D/shotgun.ammo = MapLoop.player_data["weapon2_bullets"]
		$Camera3D/SubViewportContainer/SubViewport/Camera3D/smg.ammo = MapLoop.player_data["weapon3_bullets"]
		$Camera3D/SubViewportContainer/SubViewport/Camera3D/rifle.ammo = MapLoop.player_data["weapon4_bullets"]
		health = MapLoop.player_data["heatlh"]
		dash_amount = MapLoop.player_data["dash_amount"]
		global_position = MapLoop.local_switch_pos
		rotation.y = MapLoop.local_switch_rotation.y
		rotation.z = MapLoop.local_switch_rotation.z
		camera.rotation.x = MapLoop.local_switch_rotation.x
	
	else:
		MapLoop.init_run = false;

	update_weapons();
func _physics_process(delta: float) -> void:
	if (health <= 0):
		$Camera3D/dead.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true;
		$Camera3D/dead/again.grab_focus()


	MapLoop.timer += delta
	ui_shit();
	
	$Camera3D/SubViewportContainer/SubViewport/Camera3D.global_position = global_position
	$Camera3D/SubViewportContainer/SubViewport/Camera3D.global_rotation = global_rotation
	# Add the gravity.
	#headbob(delta);
	var current_fov = 90;

	
	var look_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")

	if (look_dir):
		rotation.y -= look_dir.x * controller_look_sense * ((Settings.look_sense + 50) / 100.0)
		camera.rotation.x -= look_dir.y * controller_look_sense * ((Settings.look_sense + 50) / 100.0)
		camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2);

	change_weapons()
	crouch();
	if not is_on_floor() and !dash_direction:
		velocity += get_gravity() * delta
	if (Input.is_action_just_pressed("jump") and can_double_jump and MapLoop.player_data["double_jump"]):
		can_double_jump = false;
		jump()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		can_double_jump = true;


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * (0.5 if is_crouching else 1.0);
		velocity.z = direction.z * SPEED * (0.5 if is_crouching else 1.0);
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	current_fov += (5 if is_dashing else 0)
	current_fov += (5 if velocity != Vector3.ZERO else 0)
	if (MapLoop.player_data["dash"]):
		dash(delta, input_dir);
	juice(delta, input_dir, current_fov);

	gun_stuff()
	if (MapLoop.end):
		end()

	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	#$jump.play()
func change_weapons():
	if (Input.is_action_just_pressed("weapon1") and MapLoop.player_data["weapon1"]):
		current_gun = "pistol"
		update_weapons()
		return
	elif (Input.is_action_just_pressed("weapon2") and MapLoop.player_data["weapon2"]):
		current_gun = "shotgun"
		
		update_weapons()
		return
	elif (Input.is_action_just_pressed("weapon3") and MapLoop.player_data["weapon3"]):
		current_gun = "smg"
		update_weapons()
		return
	elif (Input.is_action_just_pressed("weapon4") and MapLoop.player_data["weapon4"]):
		current_gun = "rifle"
		update_weapons()
		return


func update_weapons():
	var ui_bullet = load("res://player/" + current_gun + "_bullet_ui.png")
	for i in range(12):
		get_node("Camera3D/ui/ammo1/TextureRect" + str(i + 1)).texture = ui_bullet
	for i in range(12):
		get_node("Camera3D/ui/ammo2/TextureRect" + str(i + 1)).texture = ui_bullet
	for i in range(12):
		get_node("Camera3D/ui/ammo3/TextureRect" + str(i + 1)).texture = ui_bullet
	if (current_gun == "shotgun"):
		$Camera3D/ui/CenterContainer/TextureRect.texture = load("res://player/shotgun_crosshair.png")
	else:
		$Camera3D/ui/CenterContainer/TextureRect.texture = load("res://player/normal_crosshair.png")

	$Camera3D/SubViewportContainer/SubViewport/Camera3D/smg.visible = current_gun == "smg"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/shotgun.visible = current_gun == "shotgun"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/pistol.visible = current_gun == "pistol"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/rifle.visible = current_gun == "rifle"

	$Camera3D/SubViewportContainer/SubViewport/Camera3D/smg.is_current_weapon = current_gun == "smg"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/shotgun.is_current_weapon = current_gun == "shotgun"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/pistol.is_current_weapon = current_gun == "pistol"
	$Camera3D/SubViewportContainer/SubViewport/Camera3D/rifle.is_current_weapon = current_gun == "rifle"

	
func gun_stuff():
	if (Input.is_action_just_pressed("reload")):
		get_node("Camera3D/SubViewportContainer/SubViewport/Camera3D/" + current_gun).reload()

func ui_shit():
	$Camera3D/ui/dash.visible = MapLoop.player_data["dash"]
	$Camera3D/ui/timer/minutes.text = ("0" if int(MapLoop.timer / 60) < 10 else "") + str(int(MapLoop.timer / 60))
	$Camera3D/ui/timer/seconds.text = ("0" if int(int(MapLoop.timer) % 60) < 10 else "") + str(int(int(MapLoop.timer) % 60))
	$Camera3D/ui/timer/miliseconds.text = ("0" if (int(int(MapLoop.timer * 60) % 60)) < 10 else "") + str(int(int(MapLoop.timer * 60) % 60))
	$Camera3D/ui/timer.visible = Settings.timer_active
	var tween = get_tree().create_tween()
	tween.tween_property($Camera3D/ui/health, "value", health, 0.1)
	tween.set_parallel()
	tween.tween_property($Camera3D/ui/dash, "value", dashs, 0.1)
	
	
	for i in range(12):
		get_node("Camera3D/ui/ammo1/TextureRect" + str(i + 1)).visible = i + 24 < get_node("Camera3D/SubViewportContainer/SubViewport/Camera3D/" + current_gun).ammo
	for i in range(12):
		get_node("Camera3D/ui/ammo2/TextureRect" + str(i + 1)).visible = i + 12 < get_node("Camera3D/SubViewportContainer/SubViewport/Camera3D/" + current_gun).ammo
	for i in range(12):
		get_node("Camera3D/ui/ammo3/TextureRect" + str(i + 1)).visible = i < get_node("Camera3D/SubViewportContainer/SubViewport/Camera3D/" + current_gun).ammo


func _input(event: InputEvent) -> void:
	if (event.is_action("esc") and can_pause):
		print("PAUSED")
		$Camera3D/pause.can_un_pause = false
		$Camera3D/pause/can_un_pause_timer.start()
		paused = true
		update_mouse_mode()
		can_pause = false;
		$Camera3D/pause.opened()

	if event is InputEventMouseMotion:
		rotation.y += (-event.relative.x * LOOK_SENSE * ((Settings.look_sense + 50) / 100.0));
		camera.rotation.x += (-event.relative.y * LOOK_SENSE * ((Settings.look_sense + 50) / 100.0))
		camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2);
		

func headbob(delta):
	if (velocity.x + velocity.z != 0):
		headbob_timer += delta * headbob_speed
	if (headbob_timer > PI):
		headbob_timer = 0;


func juice(delta, input_dir, current_fov):
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "rotation:z", ((deg_to_rad(-3) * input_dir.x) if input_dir else 0), 0.2)
	tween.set_parallel()
	tween.tween_property(camera, "fov", current_fov, 0.2)


func vec3tovec2(vec3: Vector3) -> Vector2:
	return Vector2(vec3.x, vec3.z);
	
func dash(delta, input_dir):
	if (is_on_floor()):
		dashs = 3;
	if (Input.is_action_just_pressed("dash") and !is_dashing and dashs > 0): # start dash
		$dash.play()
		dash_timer = dash_amount;
		dashs -= 1;
		is_dashing = true;
		if (input_dir):
			velocity.y = 0;
			dash_direction = vec3tovec2((transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized());
		else:
			dash_direction = vec3tovec2((transform.basis * Vector3(0, 0, -1)).normalized());
	if (dash_timer >= 0):
		dash_timer -= delta
		velocity.x = dash_direction.x * dash_speed
		velocity.z = dash_direction.y * dash_speed
	
	else:
		if (is_dashing):
			is_dashing = false;
			dash_direction = Vector2.ZERO


func crouch():
	is_crouching = Input.is_action_pressed("crouch") and is_on_floor();
	if $crouchcast.is_colliding() and !is_crouching:
		is_crouching = true
	
	$CollisionShape3D.shape.height = 1 if is_crouching else 2;
	$CollisionShape3D.position.y = -0.5 if is_crouching else 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "position:y", 0 if is_crouching else 1, 0.1)


func update_mouse_mode():
	if paused:
		$Camera3D/pause.visible = true;
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		$Camera3D/pause.visible = false;
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func end():
	velocity = (MapLoop.end_pull - global_position).normalized() * 40


func _on_can_pause_timeout() -> void:
	can_pause = true
