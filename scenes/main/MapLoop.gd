extends Node

var local_switch_pos;
var local_switch_rotation;
var player_velocity
var player_data = {
	"weapon1" : true,
	"weapon2" : false,
	"weapon3" : false,
	"weapon4" : false,
	"double_jump" : false,
	"dash" : false,
	"current_gun" : "pistol",
	"weapon1_bullets" : 0,
	"weapon2_bullets" : 0,
	"weapon3_bullets" : 0,
	"weapon4_bullets" : 0,
	"health" : 0,
	"dash_amount" : 0,
	"grenade" :false,
}
var init_run = true;


var end = false
var end_pull;
var timer = 0;