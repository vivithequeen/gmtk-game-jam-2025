@tool
extends Node3D

var height : int = 0;
var start_pos : Vector3

enum doors{
	LARGE_DOOR,
	SMALL_DOOR,
	MEDIUM_DOOR,
}

var is_open : bool = false

@export var update : bool :
	set(value):
		update_doors()
		reset()
		

@export var close : bool :
	set(value):
		close_door()
@export var open : bool :
	set(value):
		open_door()

@export var door_type : doors 
@export var default_open : bool

func _ready() -> void:
	update_doors()

func update_doors():

	
	if(door_type == doors.SMALL_DOOR):
		height = 8
	elif(door_type == doors.LARGE_DOOR):
		height = 11
	elif(door_type == doors.MEDIUM_DOOR):
		height = 8
	
	if(default_open and !Engine.is_editor_hint()):
		open_door()

	start_pos = global_position
	$large_door.visible = door_type == doors.LARGE_DOOR
	$small_door.visible = door_type == doors.SMALL_DOOR
	$med_door.visible = door_type == doors.MEDIUM_DOOR

	$"large_door/entity_0_geometry_col/CollisionShape3D".disabled = door_type != doors.LARGE_DOOR
	$"small_door/entity_0_geometry_col/CollisionShape3D".disabled = door_type != doors.SMALL_DOOR
	$"med_door/entity_0_geometry_col/CollisionShape3D".disabled = door_type != doors.MEDIUM_DOOR


func reset():
	position = start_pos
	is_open = false

func open_door():
	if(!is_open):
		is_open = true;
		var tween = get_tree().create_tween()
		var end = global_position.y - height
		tween.tween_property(self,"global_position:y",end,0.4)

func close_door():
	if(is_open):
		is_open = false;
		var tween = get_tree().create_tween()
		var end = global_position.y + height
		tween.tween_property(self,"global_position:y",end,0.4)
