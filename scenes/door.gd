@tool
extends Node3D

var height : int = 0;


enum doors{
	LARGE_DOOR,
	SMALL_DOOR,
	
}
var is_open : bool = false

@export var update : bool :
	set(value):
		reset()
		update_doors()

@export var close : bool :
	set(value):
		close_door()
@export var open : bool :
	set(value):
		open_door()

@export var door_type : doors 
@export var default_open : bool


func update_doors():

	if(door_type == doors.SMALL_DOOR):
		height = 8
	elif(door_type == doors.LARGE_DOOR):
		height = 11

	$large_door.visible = door_type == doors.LARGE_DOOR
	$small_door.visible = door_type == doors.SMALL_DOOR


func reset():
	position = Vector3.ZERO
	is_open = false

func open_door():
	if(!is_open):
		is_open = true;
		var tween = get_tree().create_tween()
		var end = global_position.y - height
		print(end)
		tween.tween_property(self,"global_position:y",end,0.4)

func close_door():
	if(is_open):
		is_open = false;
		var tween = get_tree().create_tween()
		var end = global_position.y + height
		tween.tween_property(self,"global_position:y",end,0.4)
