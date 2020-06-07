extends Sprite

var woke = false
var target
var speed = 0
var accel = .2
var max_alpha = 0.5
var min_alpha = 0
var fade_speed = .06


func _ready():
	$Area2D.connect('body_entered', self, '_on_body_entered')


func _on_body_entered(body):
	if (!woke && body.get('bodyType') && body.bodyType == 'bubble'):
		woke = true
		target = body
	

func _process(_delta):
	# do nothing of not triggered
	if (!woke):
		return
		
	# fade out if near bubble
	if (target.position.distance_to(position) < 30):
		modulate.a -= fade_speed
	elif (modulate.a < max_alpha):
		modulate.a += fade_speed
		
	# remove dot if alpha reaches 0
	if (modulate.a <= min_alpha):
		queue_free()
		return
		
	# move towards target bubble
	var vector = (target.position - position).normalized()
	position += vector * speed
	speed += accel
