extends Node2D

var player_id = 'bob'
var target_position
var shared_state


# start an interval
func _ready():
	shared_state = get_node("../../SharedState")


# Track the mouse
func _process(_delta):
	target_position = get_global_mouse_position()


# Send updates on an interval
func _on_interval():
	shared_state.set_player_target_position(player_id, target_position)
