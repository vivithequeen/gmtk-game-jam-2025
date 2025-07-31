extends CharacterBody3D


const SPEED = 9.0
const JUMP_VELOCITY = 6.0;
const LOOK_SENSE = 0.0025;

var controller_look_sense = 0.07;

@onready var camera = $Camera3D

#headbob
var headbob_timer = 0;
var headbob_speed = 6;
var headbob_distance = 0.4;

var paused := false;

var can_double_jump := false;

#dash
var dash_timer := 0.0;
var dash_amount := 0.15;
var dash_speed :=40.0;
var dash_direction : Vector2
var is_dashing:= false;
var is_crouching = false
var dashs = 3;

func _ready() -> void:
	update_mouse_mode()
func _physics_process(delta: float) -> void:
	
	$Camera3D/SubViewportContainer/SubViewport/Camera3D.global_position = global_position
	$Camera3D/SubViewportContainer/SubViewport/Camera3D.global_rotation = global_rotation
	# Add the gravity.
	#headbob(delta);
	var current_fov = 90;

	
	var look_dir = Input.get_vector("look_left","look_right","look_up","look_down")

	if(look_dir):
		rotation.y-=look_dir.x * controller_look_sense
		camera.rotation.x-=look_dir.y * controller_look_sense
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2);


	crouch();
	if not is_on_floor() and !dash_direction:
		velocity += get_gravity() * delta
	if(Input.is_action_just_pressed("jump") and can_double_jump):
		can_double_jump = false;
		velocity.y = JUMP_VELOCITY
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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
	current_fov+=(5 if is_dashing else 0)
	current_fov+=(5 if velocity != Vector3.ZERO else 0)
	dash(delta,input_dir);
	juice(delta,input_dir,current_fov);
	move_and_slide()


func _input(event: InputEvent) -> void:
	
	
	if event is InputEventMouseMotion:
		rotation.y +=(-event.relative.x * LOOK_SENSE);
		camera.rotation.x+=(-event.relative.y*LOOK_SENSE)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2);
		

func headbob(delta):
	if (velocity.x + velocity.z != 0):
		headbob_timer += delta * headbob_speed
	if (headbob_timer > PI):
		headbob_timer = 0;


func juice(delta, input_dir,current_fov):
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "rotation:z",((deg_to_rad(-3) * input_dir.x) if input_dir else 0), 0.2)
	tween.set_parallel()
	tween.tween_property(camera, "fov", current_fov,0.2)


func vec3tovec2(vec3 : Vector3) ->Vector2:
	
	return Vector2(vec3.x,vec3.z);
	
func dash(delta,input_dir):
	if(is_on_floor()):
		dashs = 3;
	if(Input.is_action_just_pressed("dash") and !is_dashing and dashs > 0):#start dash
		dash_timer = dash_amount;
		dashs-=1;
		is_dashing = true;
		if(input_dir):
			velocity.y = 0;
			dash_direction = vec3tovec2((transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized());
		else:
			dash_direction = vec3tovec2((transform.basis * Vector3(0, 0, -1)).normalized());
	if(dash_timer>=0):
		dash_timer-=delta
		velocity.x =dash_direction.x * dash_speed
		velocity.z =dash_direction.y * dash_speed
	
	else:
		if(is_dashing):
			is_dashing = false;
			dash_direction = Vector2.ZERO




func crouch():
	is_crouching = Input.is_action_pressed("crouch") and is_on_floor();
	if $crouchcast.is_colliding() and !is_crouching :
		is_crouching = true
	
	$CollisionShape3D.shape.height = 1 if is_crouching else 2;
	$CollisionShape3D.position.y = -0.5 if is_crouching else 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(camera,"position:y",0 if is_crouching else 1,0.1)



func update_mouse_mode():
	
	if paused:
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
