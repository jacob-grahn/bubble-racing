extends Sprite

var woke = false
var target
var speed = 0


func _ready():
	$Area2D.connect('body_entered', self, '_on_body_entered')


func _on_body_entered(body):
	if (!woke && body.get('bodyType') && body.bodyType == 'bubble'):
		woke = true
		target = body
	

func _process(delta):
	if (!woke):
		return
	if (target.position.distance_to(position) < 30):
		modulate.a -= .05
	if (modulate.a <= 0):
		queue_free()
		return
	var vector = (target.position - position).normalized()
	position += vector * speed
	speed += 0.15
