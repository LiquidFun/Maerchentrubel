extends Node

var sounds = [
	"res://Resources/Sound/Music/background.ogg",
	"res://Resources/Sound/Music/background2.ogg",
	"res://Resources/Sound/Music/background3.ogg",
]
var previous = -1

var stopped = false

var audio_player = null

func add_audio(sound):
	sounds.append(sound)

func _on_stream_finished():
	play()
	
func play():
	stopped = false
	previous = Globals.new_different_random_index(0, len(sounds)-1, previous)
	audio_player = AudioManager.play(sounds[previous], false, -12)
	audio_player.connect("finished", self, "_on_stream_finished")

func stop():
	audio_player.stop()
