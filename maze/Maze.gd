extends Node2D

var Box = preload("../box/Box.tscn")
var boxWidth = 10
var boxScale = 0.1
var nodeWidth = boxWidth * 3


func _ready():
	position = Vector2(50, 50)
	
	var maze = MazeGenerator.generate(10, 10)
	for node in maze:
		draw_node(node)
		
		
func draw_box(x, y):
	var box = Box.instance()
	box.scale = Vector2(boxScale, boxScale)
	box.position = Vector2(x, y)
	add_child(box)
	
	
func draw_node(node):
	var up = false
	var right = false
	var down = false
	var left = false
	var x = node.x * nodeWidth
	var y = node.y * nodeWidth
	
	for connection in node.connections:
		if node.y - connection.y > 0:
			up = true
		if node.x - connection.x < 0:
			right = true
		if node.y - connection.y < 0:
			down = true
		if node.x - connection.x > 0:
			left = true
			
	# add corners
	draw_box(x, y)
	draw_box(x + (boxWidth * 2), y)
	draw_box(x + (boxWidth * 2), y + (boxWidth * 2))
	draw_box(x, y + (boxWidth * 2))
	
	# add walls
	if !up:
		draw_box(x + boxWidth, y)
	if !right:
		draw_box(x + (boxWidth * 2), y + boxWidth)
	if !down:
		draw_box(x + boxWidth, y + (boxWidth * 2))
	if !left:
		draw_box(x, y + boxWidth)
		
	if (node.x == 0 and node.y == 0):
		print(node)
