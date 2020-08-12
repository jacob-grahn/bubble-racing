extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 14):
		var btn = get_node("Center/LevelList/B" + str(i))
		btn.connect('button_down', self, '_on_press_level_' + str(i))
	
func _on_press_level_1():
	goto_level({
		'width': 1,
		'height': 2
	})
	
func _on_press_level_2():
	goto_level({
		'width': 2,
		'height': 4
	})
	
func _on_press_level_3():
	goto_level({
		'width': 3,
		'height': 5
	})
	
func _on_press_level_4():
	goto_level({
		'width': 4,
		'height': 4
	})
	
func _on_press_level_5():
	goto_level({
		'width': 5,
		'height': 5
	})
	
func _on_press_level_6():
	goto_level({
		'width': 6,
		'height': 6
	})
	
func _on_press_level_7():
	goto_level({
		'width': 7,
		'height': 7
	})
	
func _on_press_level_8():
	goto_level({
		'width': 8,
		'height': 8
	})
	
func _on_press_level_9():
	goto_level({
		'width': 9,
		'height': 9
	})
	
func _on_press_level_10():
	goto_level({
		'width': 10,
		'height': 10
	})
	
func _on_press_level_11():
	goto_level({
		'width': 11,
		'height': 11
	})
	
func _on_press_level_12():
	goto_level({
		'width': 12,
		'height': 12
	})
	
func _on_press_level_13():
	goto_level({
		'width': 13,
		'height': 13
	})
	
func _on_press_level_14():
	goto_level({
		'width': 14,
		'height': 14
	})
	
func goto_level(levelSettings):
	Settings.levelSettings = levelSettings
	get_tree().change_scene("res://maze/Maze.tscn")
