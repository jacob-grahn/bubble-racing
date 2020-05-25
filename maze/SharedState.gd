extends Node

var Map2D = preload("../maze/Map2D.gd")

var map = Map2D.new()
var players = {}


func clear():
	map.clear()
	players = {}
	

func add_player(player):
	var id = player.id
	players[id] = player


func set_player_target_position(player_id, target_position):
	if (!players.get(player_id)):
		players[player_id] = {}
	players[player_id].target_position = target_position
