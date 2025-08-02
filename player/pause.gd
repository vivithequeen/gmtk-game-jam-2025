extends Control

@export var player :CharacterBody3D
# Called when the node enters the scene tree for the first time.

var can_un_pause : bool = false
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("esc") and can_un_pause):
		unpause()


func _on_contiue_pressed() -> void:
	unpause()
	$select.play()

func unpause():
	player.paused = false;
	player.get_node("can_pause").start()
	player.update_mouse_mode()
	$select.play()


func _on_can_un_pause_timeout() -> void:
	can_un_pause = true
