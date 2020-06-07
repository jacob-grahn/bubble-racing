extends Node

var elapsed = 0
var data
var stream_player
# var got_stream = false
var loudness = 0
var json_url = "https://f000.backblazeb2.com/file/bubbleracing/songs/trumpetz.json"
var song_url = "https://f000.backblazeb2.com/file/bubbleracing/songs/trumpetz.mp3"


# Called when the node enters the scene tree for the first time.
func _ready():
	var JSON_request = HTTPRequest.new()
	add_child(JSON_request)
	JSON_request.connect("request_completed", self, "on_json_request_completed")
	JSON_request.request(json_url)
	
	if (Settings.sound):
		JavaScript.eval("SoundPlayer.play('" + song_url + "')")
	# var OGG_request = HTTPRequest.new()
	# add_child(OGG_request)
	# OGG_request.connect("request_completed", self, "on_ogg_request_completed")
	# OGG_request.request(ogg_url)
	
	# stream_player = get_node("../AudioStreamPlayer")
	# stream_player.connect("finished", self, "on_audio_finished")
	

func on_json_request_completed(_result, _response_code, _headers, body):
	var data_parse = JSON.parse(body.get_string_from_utf8())
	if data_parse.error != OK:
		return
	data = data_parse.result
	
	
# func on_ogg_request_completed(result, response_code, headers, body):
#	var stream = AudioStreamOGGVorbis.new()
#	stream.data = body
#	stream_player.stream = stream
#	got_stream = true
#	on_audio_finished()
	

# func on_audio_finished():
#	elapsed = 0
#	stream_player.play()


func _process(delta):
	if (!data):
		return
	elapsed += delta
	var index = int(round(elapsed * 100) + 10) % data.size()
	var dBFS = -data[index]
	var newLoudness = max(12 + dBFS, 0) * 10
	loudness = ((loudness * 3) + newLoudness) / 4


func _on_Timer_timeout():
	var timeStr = JavaScript.eval("SoundPlayer.getCurrentTime()")
	if (timeStr):
		var time = float(timeStr)
		elapsed = time
	else:
		elapsed = 0
