extends RigidBody2D

# variables
var acceleration = 30
var linearDamp = 3
var targetPosition = Vector2(0, 0)
var approachBackoff = 200
var mouseIsDown = false
var bodyType = 'bubble'
var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(linearDamp)
	targetPosition = position

# Track the mouse when it is pressed
func _input(event):
	if finished:
		return
	if event is InputEventMouseButton:
		mouseIsDown = event.pressed
		targetPosition = get_global_mouse_position()

# Move towards target position
func _process(_delta):
	if finished:
		return
	# if (mouseIsDown):
	targetPosition = get_global_mouse_position()
	var vector = (targetPosition - position).normalized()
	var dist = targetPosition.distance_to(position)
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
