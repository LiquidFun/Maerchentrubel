extends Node


var rng = RandomNumberGenerator.new()

var sounds = [
	"Sfx/chirp1.ogg",
	"Sfx/chirp2.ogg",
	"Sfx/chirp3.ogg",
	"Sfx/chirp4.ogg",
	"Sfx/chirp5.ogg"
]

var stopped = false
var previous = -1

var noise = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	noise = AudioManager.play("Sfx/noise.ogg", true, 0, AudioManager.Type.NOISE)

func _on_stream_finished(p):
	yield(get_tree().create_timer(rng.randf_range(0, 5)), "timeout")
	play()
	
func play():
	stopped = false
	previous = Globals.new_different_random_index(0, len(sounds)-1, previous)
	AudioManager.play(sounds[previous], false, -20)

func stop():
	noise.stop()
	stopped = true
