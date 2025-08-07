extends AudioStreamPlayer3D

@export var is_music : bool = false;
@export var is_sfx : bool = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("audio")

func update():
	volume_db = Settings.settings["master_db"]
