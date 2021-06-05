extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

var sounds = []

var stopped = false

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
	var i = rng.randi_range(0,len(sounds) - 1)
	var p = AudioManager.play(sounds[i])
	p.connect("finished", self, "_on_stream_finished", [p])

func stop():
	stopped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
