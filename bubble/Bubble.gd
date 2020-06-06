extends "../maze/Mover.gd"

# variables
var finished = false


# Called when the node enters the scene tree for the first time.
func _ready():
	bodyType = 'bubble'
	$MouseTracker.target_position = position
	._ready()


# Move towards target position
func _process(_delta):
	if finished:
		return
	target_position = $MouseTracker.target_position
	beat_light()
	

func beat_light():
	var lightScale = 0.5 + (get_node("../BeatBoxer").loudness * .006)
	var bubbleScale = 0.5 + (get_node("../BeatBoxer").loudness * .001)
	$Light2D.set_scale(Vector2(lightScale, lightScale))
	$Sprite.set_scale(Vector2(bubbleScale, bubbleScale))
	
	
func finish():
	finished = true
