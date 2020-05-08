extends Node2D
signal bubble_finished

func _on_Area2D_body_entered(body):
	if body.get('bodyType') && body.bodyType == 'bubble':
		emit_signal('bubble_finished', body)
