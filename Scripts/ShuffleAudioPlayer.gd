extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

var sounds = [
	"res://Resources/Sound/Music/background.ogg",
	"res://Resources/Sound/Music/background2.ogg",
	"res://Resources/Sound/Music/background3.ogg",
]
var previous_index = -1

var stopped = false

var current_audio_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func add_audio(sound):
	sounds.append(sound)

func _on_stream_finished(p):
	play()
	
func play():
	stopped = false
	var different_index
	while true:
		different_index = rng.randi_range(0, len(sounds) - 1)
		if different_index != previous_index:
			break
	previous_index = different_index
	var audio_player = AudioManager.play(sounds[different_index], false, -12)
	audio_player.connect("finished", self, "_on_stream_finished", [audio_player])
	current_audio_player = audio_player

func stop():
	current_audio_player.stop()
