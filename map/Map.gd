extends Node2D

func _ready():
	$Finish.connect("bubble_finished", self, "on_bubble_finished")
	$Finish2.connect("bubble_finished", self, "on_bubble_finished")

func on_bubble_finished(bubble: RigidBody2D):
	bubble.finish()
	get_tree().reload_current_scene()
