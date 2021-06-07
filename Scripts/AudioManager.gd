extends Node


var num_players = 8
var bus = "master"

var available = []  # The available players.

var queue = []  # The queue of sounds to play.

var playing = []

enum Type {MUSIC, NARRATOR, SFX, NOISE, OTHER, AUTO}
var audio_players = {}	
var _string_to_audio_type = {}

func _ready():
	for type in Type:
		audio_players[type] = AudioStreamPlayer.new()
		_string_to_audio_type[str(type)] = type

func _on_stream_finished(stream):
	remove_child(stream)

func play(sound_path, loop=false, volume=-10, type=Type.AUTO):
	sound_path = sound_path.trim_prefix("res://Resources/Sound/")
	if type == Type.AUTO:
		var sound_folder = sound_path.split("/")[0]
		type = _string_to_audio_type[sound_folder.to_upper()]
	print(type)
	var audio_player = audio_players[type]
	add_child(audio_player)
	#audio_player.connect("finished", self, "_on_stream_finished", [audio_player])
	audio_player.bus = bus
	
	sound_path = "res://Resources/Sound/" + sound_path
	print(sound_path)
	audio_player.stream = load(sound_path)
	audio_player.stream.set_loop(loop)
	audio_player.volume_db = clamp(volume, -80, 10)
	audio_player.play()
	return audio_player

#func _process(delta):
	# Play a queued sound if any players are available.
	#if not queue.empty() and not available.empty():
	#	var front = queue.pop_front()
	#	available[0].stream = front["sound"]
	#	if not front["loop"]:
	#		available[0].stream.set_loop(false)
	#	available[0].play()
#	pass
