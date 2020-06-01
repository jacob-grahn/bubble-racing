extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayButton.connect('button_down', self, '_on_press_play')


func _on_press_play():
	get_tree().change_scene("res://maze/Maze.tscn")
