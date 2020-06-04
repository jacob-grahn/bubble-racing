extends Node2D


func _ready():
	$Center/PlayButton.connect('button_down', self, '_on_press_play')


func _on_press_play():
	get_tree().change_scene("res://maze/Maze.tscn")
