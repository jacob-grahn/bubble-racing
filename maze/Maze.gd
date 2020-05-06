extends Node2D

var Box = preload("../box/Box.tscn")
var TileMap = preload("./TileMap.gd")
var boxWidth = 100
var boxScale = 1
var nodeWidth = boxWidth * 3
var map = TileMap.new()


func _ready():
	randomize()
	
	var maze = MazeGenerator.generate(10, 10)
	maze.shuffle()
	
	for node in maze:
		draw_node(node)
		
	$Bubble.position = Vector2(300, 2900)


func draw_box(x, y):
	var top = 1 if map.getTile(x, y - 1) else 0
	var right = 1 if map.getTile(x + 1, y) else 0
	var bottom = 1 if map.getTile(x, y + 1) else 0
	var left = 1 if map.getTile(x - 1, y) else 0
	# var neighbor_count = top + right + bottom + left
	if (!top and !bottom) or (!right and !left):
		var box = Box.instance()
		box.scale = Vector2(boxScale, boxScale)
		box.position = Vector2(x * boxWidth, y * boxWidth)
		add_child(box)
		map.setTile(x, y, true)


func draw_node(node):
	var up = false
	var right = false
	var down = false
	var left = false
	var x = node.x * 3
	var y = node.y * 3
	
	for connection in node.connections:
		if node.y - connection.y > 0:
			up = true
		if node.x - connection.x < 0:
			right = true
		if node.y - connection.y < 0:
			down = true
		if node.x - connection.x > 0:
			left = true
	
	# exit
	if node.y == 0 and node.x == 5:
		up = true
	
	# add corners
	draw_box(x, y)
	draw_box(x + 2, y)
	draw_box(x + 2, y + 2)
	draw_box(x, y + 2)
	
	# add walls
	if !up:
		draw_box(x + 1, y)
	if !right:
		draw_box(x + 2, y + 1)
	if !down:
		draw_box(x + 1, y + 2)
	if !left:
		draw_box(x, y + 1)
