extends Node

var fullscreen : bool = true;
var timer_active: bool = true;
var popups : bool = true
var volumn_db : float = 0;
var look_sense : float = 50

func toggle_fullscreen():
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
