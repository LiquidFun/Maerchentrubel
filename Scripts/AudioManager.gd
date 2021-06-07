extends Node


var num_players = 8
var bus = "master"

var available = []  # The available players.

var queue = []  # The queue of sounds to play.

var playing = []

enum Type {MUSIC=0, NARRATOR=1, SFX=2, NOISE=3, OTHER=4, AUTO=5}
var audio_players = {}
var _string_to_audio_type = {}

func _ready():
	var i = 0
	for type in Type:
		audio_players[type] = AudioStreamPlayer.new()
		_string_to_audio_type[int(i)] = type
		_string_to_audio_type[str(int(i))] = type
		_string_to_audio_type[type] = type
		i += 1
	print(audio_players)

func _on_stream_finished(stream):
	remove_child(stream)

func play(sound_path, loop=false, volume=-10, type=AudioManager.Type.AUTO):
	sound_path = sound_path.trim_prefix("res://Resources/Sound/")
	if type == AudioManager.Type.AUTO:
		var sound_folder = sound_path.split("/")[0]
		type = _string_to_audio_type[sound_folder.to_upper()]
	print(type)
	var audio_player
	audio_player = audio_players[_string_to_audio_type[type]]
	add_child(audio_player)
	#audio_player.connect("finished", self, "_on_stream_finished", [audio_player])
	audio_player.bus = bus
	
	sound_path = "res://Resources/Sound/" + sound_path.trim_prefix("/")
	audio_player.stream = load(sound_path)
	audio_player.stream.set_loop(loop)
	audio_player.volume_db = clamp(volume, -80, 15)
	audio_player.play()
	return audio_player
