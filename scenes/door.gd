@tool
extends Node3D


enum doors{
	LARGE_DOOR,
	SMALL_DOOR,
}

@export var door_type : doors :
	set(value):

		update_doors()


func update_doors():
	$large_door.visible = door_type == doors.LARGE_DOOR
	$small_door.visible = door_type == doors.SMALL_DOOR