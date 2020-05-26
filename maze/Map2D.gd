extends Object

var map = {}

func getTile(x, y):
	if !map.get(x):
		return null
	return map[x].get(y)
	
func setTile(x, y, value):
	if !map.get(x):
		map[x] = {}
	map[x][y] = value

func setMap(_map):
	map = _map

func clear():
	map = {}
