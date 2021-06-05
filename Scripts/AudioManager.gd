extends Node

var num_players = 8
var bus = "master"

var available = []  # The available players.

var queue = []  # The queue of sounds to play.

var playing = []

func _ready():
	pass
	# Create the pool of AudioStreamPlayer nodes.
	#for i in num_players:
	#	var p = AudioStreamPlayer.new()
	#	add_child(p)
	#	available.append(p)
	#	p.connect("finished", self, "_on_stream_finished", [p])
	#	p.bus = bus

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	#available.append(stream)
	remove_child(stream)

func play(sound_path, loop=false, volume=-10):
	var p = AudioStreamPlayer.new()
	add_child(p)
	p.connect("finished", self, "_on_stream_finished", [p])
	p.bus = bus
	p.stream = load(sound_path)
	p.stream.set_loop(loop)
	p.volume_db = clamp(volume, -80, 0)
	p.play()
	return p

func _process(delta):
	# Play a queued sound if any players are available.
	#if not queue.empty() and not available.empty():
	#	var front = queue.pop_front()
	#	available[0].stream = front["sound"]
	#	if not front["loop"]:
	#		available[0].stream.set_loop(false)
	#	available[0].play()
	pass
