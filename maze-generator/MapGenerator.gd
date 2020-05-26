extends Node

var Map2D = preload("../maze/Map2D.gd")
var map


func generate(maze, mazeWidth):
	map = Map2D.new()
	maze.shuffle()
	
	for node in maze:
		add_node(node, mazeWidth)

	return map
	

func add_node(node, mazeWidth):
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
	if node.y == 0 and node.x == floor(mazeWidth / 2):
		up = true
	
	# add corners
	add_box(x, y)
	add_box(x + 2, y)
	add_box(x + 2, y + 2)
	add_box(x, y + 2)
	
	# add walls
	if !up:
		add_box(x + 1, y)
	if !right:
		add_box(x + 2, y + 1)
	if !down:
		add_box(x + 1, y + 2)
	if !left:
		add_box(x, y + 1)


func add_box(x, y):
	var top = 1 if map.getTile(x, y - 1) else 0
	var right = 1 if map.getTile(x + 1, y) else 0
	var bottom = 1 if map.getTile(x, y + 1) else 0
	var left = 1 if map.getTile(x - 1, y) else 0
	if (!top and !bottom) or (!right and !left):
		map.setTile(x, y, true)
