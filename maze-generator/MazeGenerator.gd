extends Node

func generate(width, height):
	var node_list = make_nodes(width, height)
	connect_nodes_randomly(node_list)
	return node_list
	
	
func make_nodes(width, height):
	var node_list = []
	for x in range(width):
		for y in range(height):
			var node = {'x': x, 'y': y, 'connections': []}
			node_list.push_back(node)
	return node_list


func connect_nodes_randomly(node_list):
	var unused_node_list = node_list.duplicate()
	unused_node_list.shuffle()
	var stack = [unused_node_list.pop_back()]
	while unused_node_list.size() > 0:
		var node = stack[stack.size() - 1]
		var moved_forward = false
		for other_node in unused_node_list:
			var dist_x = other_node.x - node.x
			var dist_y = other_node.y - node.y
			var dist = sqrt((dist_x * dist_x) + (dist_y * dist_y))
			if dist <= 1:
				stack.push_back(other_node)
				unused_node_list.erase(other_node)
				node.connections.push_back({'x': other_node.x, 'y': other_node.y})
				other_node.connections.push_back({'x': node.x, 'y': node.y})
				moved_forward = true
				break
		if !moved_forward:
			stack.pop_back()
