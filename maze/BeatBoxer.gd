extends Node

var elapsed = 0
var data
var stream
var loudness = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var data_file = File.new()
	if data_file.open("res://volume.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	data = data_parse.result
	
	stream = get_node("../AudioStreamPlayer")
	stream.connect("finished", self, "on_audio_finished")
	on_audio_finished()


func on_audio_finished():
	elapsed = 0
	stream.play()

func _process(delta):
	if (!data):
		return
	elapsed += delta
	var index = int(round(elapsed * 100) + 10) % data.size()
	var dBFS = -data[index]
	var newLoudness = max(12 + dBFS, 0) * 10
	loudness = ((loudness * 3) + newLoudness) / 4
	print(loudness)
