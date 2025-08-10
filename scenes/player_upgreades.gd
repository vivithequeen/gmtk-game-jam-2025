@tool
extends Area3D

@onready var popup = preload("res://player/popup.tscn")

@export var popup_message : String#after jumping to double jump!!\nreach new heights with this ability!
# Called when the node enters the scene tree for the first time.

@export var upgrade : upgrades;
@export var update : bool:
	set(value):
		update_sprites()

enum upgrades{
	DOUBLE_JUMP,
	DASH,
	BOMB,
}
func _ready() -> void:
	pass # Replace with function body.

var activated = false;



func update_sprites():
	$boots.visible = upgrade == upgrades.DOUBLE_JUMP
	$bomb.visible = upgrade == upgrades.BOMB
	$dash.visible = upgrade == upgrades.DASH
func _on_double_jump_upgrade_body_entered(body: Node3D) -> void:
	if !activated and body.get("id"):
		if body.get("id") == "player" and !MapLoop.player_data["double_jump"]:
			activated = true
			$battles.play("boot_pick_up")
			MapLoop.player_data["double_jump"] = true;
			
			$double_jump_upgrade/Sprite3D.visible = !MapLoop.player_data["double_jump"]
			if(Settings.settings["popups"]):
				
				var p = popup.instantiate()
				p.title = "double jump!!";
				p.main = "press [img]res://player/ui_icons/space.png[/img] or [img]res://player/ui_icons/a.png[/img] " + popup_message
				body.get_node("Camera3D").add_child(p)
			else:
				$AudioStreamPlayer3D.play()