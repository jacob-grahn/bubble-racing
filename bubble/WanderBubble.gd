extends "../maze/Mover.gd"

var timer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	add_child(timer)
	timer.connect("timeout", self, "_on_timeout")
	timer.start()


# Move towards target position
func _on_timeout():
	print (linear_velocity.length())
	if (linear_velocity.length() < 50):
		var move_x = rand_range(-1000, 1000)
		var move_y = rand_range(-1000, 1000)
		target_position = position + Vector2(move_x, move_y)
