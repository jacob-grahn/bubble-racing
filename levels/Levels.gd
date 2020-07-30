extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 14):
		var btn = get_node("Center/LevelList/B" + str(i))
		btn.connect('button_down', self, '_on_press_level_' + str(i))
	
func _on_press_level_1():
	goto_level(1, 3)
	
func _on_press_level_2():
	goto_level(2, 4)
	
func _on_press_level_3():
	goto_level(3, 5)
	
func _on_press_level_4():
	goto_level(4, 4)
	
func _on_press_level_5():
	goto_level(5, 5)
	
func _on_press_level_6():
	goto_level(6, 6)
	
func _on_press_level_7():
	goto_level(7, 7)
	
func _on_press_level_8():
	goto_level(8, 8)
	
func _on_press_level_9():
	goto_level(9, 9)
	
func _on_press_level_10():
	goto_level(10, 10)
	
func _on_press_level_11():
	goto_level(11, 11)
	
func _on_press_level_12():
	goto_level(12, 12)
	
func _on_press_level_13():
	goto_level(13, 13)
	
func _on_press_level_14():
	goto_level(14, 14)
	
func goto_level(w, h):
	print('goto_level')
	print(w)
	print(h)
	Settings.mazeWidth = w
	Settings.mazeHeight = h
	get_tree().change_scene("res://maze/Maze.tscn")
