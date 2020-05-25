extends RigidBody2D

# variables
var acceleration = 30
var linearDamp = 3
var approachBackoff = 200
var mouseIsDown = false
var bodyType = 'bubble'
var finished = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(linearDamp)
	$MouseTracker.target_position = position


# Move towards target position
func _process(_delta):
	if finished:
		return
	var target_position = $MouseTracker.target_position
	var vector = (target_position - position).normalized()
	var dist = target_position.distance_to(position)
	var throttledAcceleration = acceleration * min(dist, approachBackoff) / approachBackoff
	var impulse = vector * throttledAcceleration
	apply_central_impulse(impulse)
	beat_light()
	

func beat_light():
	var lightScale = 1 + (get_node("../BeatBoxer").loudness * .005)
	var bubbleScale = 1 + (get_node("../BeatBoxer").loudness * .001)
	$Light2D.set_scale(Vector2(lightScale, lightScale))
	$Sprite.set_scale(Vector2(bubbleScale, bubbleScale))
	
	
func finish():
	finished = true
