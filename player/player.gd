extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const LOOK_SENSE = 0.0025;

@onready var camera = $Camera3D

#headbob
var headbob_timer = 0;
var headbob_speed = 1;
var headbob_distance = 1;

var paused := false;

func _ready() -> void:
	update_mouse_mode()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y +=(-event.relative.x * LOOK_SENSE);
		camera.rotation.x+=(-event.relative.y*LOOK_SENSE)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2);


func headbob(delta : float):
	var is_headbob = true;

	if(is_headbob):
		headbob_timer+=delta;

		

func update_mouse_mode():
	
	if paused:
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
