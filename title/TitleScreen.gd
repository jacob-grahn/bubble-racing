extends Node2D


func _ready():
	$Center/SoundToggle.pressed = Settings.sound
	$Center/FullscreenToggle.pressed = Settings.fullscreen
	$Center/PlayButton.connect('button_down', self, '_on_press_play')
	$Center/SoundToggle.connect('toggled', self, '_on_sound_toggled')
	$Center/FullscreenToggle.connect('toggled', self, '_on_fullscreen_toggled')

func _on_press_play():
	OS.window_fullscreen = Settings.fullscreen
	get_tree().change_scene("res://levels/Levels.tscn")
	
	
func _on_sound_toggled(toggled):
	Settings.sound = toggled
	
	
func _on_fullscreen_toggled(toggled):
	Settings.fullscreen = toggled
	
