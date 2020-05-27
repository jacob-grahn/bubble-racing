extends RigidBody2D

# variables
var acceleration = 30
var linearDamp = 3
var approachBackoff = 200
var bodyType = 'mover'
var target_position = Vector2(0 ,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_damp(linearDamp)
	target_position = position


# Move towards target position
func _process(_delta):
	var vector = (target_position - position).normalized()
	var dist = target_position.distance_to(position)
	var throttledAcceleration = acceleration * min(dist, approachBackoff) / approachBackoff
	var impulse = vector * throttledAcceleration
	apply_central_impulse(impulse)
