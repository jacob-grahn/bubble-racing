extends Sprite

var bubble
var fall_y = 0
var size = 1000


func _ready():
	bubble = get_node('../../../Bubble')
	

func _process(_delta):
	fall_y += _delta * 25
	position.x = (floor(bubble.position.x / size) * size)
	position.y = (floor(bubble.position.y / size) * size) + (int(fall_y) % size)
