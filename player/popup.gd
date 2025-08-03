extends Control

var title : String = "somethines wrong"
var main : String = "somethines wrong"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$back.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Label.text = main
	$title.text = title
	get_tree().paused = true
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
