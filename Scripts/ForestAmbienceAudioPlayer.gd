extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

var sounds = [
	"res://Resources/Sound/Sfx/chirp1.ogg",
	"res://Resources/Sound/Sfx/chirp2.ogg",
	"res://Resources/Sound/Sfx/chirp3.ogg",
	"res://Resources/Sound/Sfx/chirp4.ogg",
	"res://Resources/Sound/Sfx/chirp5.ogg"
]

var stopped = false

var noise = null

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	noise = AudioManager.play("res://Resources/Sound/Sfx/noise.mp3")
	pass # Replace with function body.

#func add_audio(sound):
#	sounds.append(sound)

func _on_stream_finished(p):
	play()
	
func play():
	stopped = false
	rng.randomize()
	var i = rng.randi_range(0,len(sounds) - 1)
	var p = AudioManager.play(sounds[i], -5)
	p.connect("finished", self, "_on_stream_finished", [p])

func stop():
	noise.stop()
	stopped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
