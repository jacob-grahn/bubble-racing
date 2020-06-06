extends "../maze/Mover.gd"

# variables
var finished = false
var baseBubbleScale
var baseLightScale


# Called when the node enters the scene tree for the first time.
func _ready():
	bodyType = 'bubble'
	baseBubbleScale = $Sprite.get_scale().x
	baseLightScale = $Light2D.get_scale().x
	$MouseTracker.target_position = position
	._ready()


# Move towards target position
func _process(_delta):
	if finished:
		return
	target_position = $MouseTracker.target_position
	beat_light()
	

func beat_light():
	var lightScale = baseLightScale + (get_node("../BeatBoxer").loudness * .006)
	var bubbleScale = baseBubbleScale + (get_node("../BeatBoxer").loudness * .001)
	$Light2D.set_scale(Vector2(lightScale, lightScale))
	$Sprite.set_scale(Vector2(bubbleScale, bubbleScale))
	
	
func finish():
	finished = true
