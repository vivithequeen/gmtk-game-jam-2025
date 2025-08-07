extends Node

var settings = {
	"fullscreen": true,
	"timer_active": true,
	"popups": true,
	"master_db": 0,
	"music_db" : 0,
	"sfx_db" : 0,
	"look_sense": 50,
	"fov" : 90,
	"vsync" : false,
	
}
var settings_default = {
	"fullscreen": true,
	"timer_active": true,
	"popups": true,
	"master_db": 0,
	"music_db" : 0,
	"sfx_db" : 0,
	"look_sense": 50,
	"fov" : 90,
	"vsync" : false,
	
}

func save_game():
	var save_file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(settings)

	save_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("res://savegame.save"):
		return # Error! We don't have a save to load.


	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("res://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data


		for i in node_data.keys():
			settings[i] = node_data[i]
func toggle_fullscreen():
	if settings["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func update_vsync():
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if settings["vsync"] else DisplayServer.VSYNC_ENABLED)