extends Area3D

@export var battle : int = 1;

var activated = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body:Node3D) -> void:
	if !activated and body.get("id"):
		if body.get("id") == "player":
			activated = true;
			get_parent().call("start_battle_" + str(battle))
