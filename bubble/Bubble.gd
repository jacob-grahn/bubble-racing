extends RigidBody2D

# variables
var acceleration = 30
var linearDamp = 3
var targetPosition = Vector2(0, 0)
var approachBackoff = 200
var mouseIsDown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(linearDamp)

#
func _input(event):
	if event is InputEventMouseButton:
		mouseIsDown = event.pressed
		targetPosition = event.position
	elif event is InputEventMouseMotion and mouseIsDown:
		targetPosition = event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vector = (targetPosition - position).normalized()
	var dist = targetPosition.distance_to(position)
	var throttledAcceleration = acceleration * min(dist, approachBackoff) / approachBackoff
	var impulse = vector * throttledAcceleration
	apply_central_impulse(impulse)
