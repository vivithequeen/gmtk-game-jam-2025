extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("audio")

func update():
	volume_db = Settings.volumn_db