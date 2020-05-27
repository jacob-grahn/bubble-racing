extends Node2D

var Box = preload("../box/Box.tscn")
var Finish = preload("../finish/Finish.tscn")
var MazeGenerator = preload("../maze-generator/MazeGenerator.gd")
var MapGenerator = preload("../maze-generator/MapGenerator.gd")
var boxScale = 2
var boxWidth = 100 * boxScale
var nodeWidth = boxWidth * 3
var mazeWidth = 5
var mazeHeight = 5
var mazeGenerator = MazeGenerator.new()
var mapGenerator = MapGenerator.new()


func _ready():
	# create random maze
	randomize()
	var maze = mazeGenerator.generate(mazeWidth, mazeHeight)
	maze.shuffle()
	var map = mapGenerator.generate(maze, mazeWidth)

	#draw map
	for x in range(mazeWidth * 3):
		for y in range(mazeHeight * 3):
			if map.getTile(x, y):
				draw_box(x, y)
	
	# add player bubble
	var startX = floor(mazeWidth / 2) * boxWidth * 3
	var startY = (mazeHeight * boxWidth * 3) - (boxWidth * 2)
	$Bubble.position = Vector2(startX, startY)
	$WanderBubble.position = Vector2(startX, startY)
	
	# add finish
	var finish = Finish.instance()
	finish.scale = Vector2(4, 4)
	finish.position = Vector2(startX + boxWidth, 0)
	finish.connect("bubble_finished", self, "on_bubble_finished")
	add_child(finish)


func on_bubble_finished(bubble: RigidBody2D):
	bubble.finish()
	var _result = get_tree().reload_current_scene()
	
	
func _process(_delta):
	var bottom = mazeHeight * boxWidth * 3
	var y = $Bubble.position.y
	var brightness = 1 - (y / bottom)
	$WallModulate.set_color(Color(brightness, brightness, brightness))
	$ParallaxBackground/BGModulate.set_color(Color(brightness, brightness, brightness))


func draw_box(x, y):
	var box = Box.instance()
	box.scale = Vector2(boxScale, boxScale)
	box.position = Vector2(x * boxWidth, y * boxWidth)
	add_child(box)
