extends Node2D

const MAX_VOLUME = 20
const MIN_VOLUME = -50

export var music_on = true
var volume_modifier = 0
var music_player = null

func play(file_path, volume=-30):
	if music_on:
		var audio_player = AudioStreamPlayer.new()
		
		self.add_child(audio_player)
		audio_player.stream = load(file_path)
		audio_player.volume_db = clamp(volume + volume_modifier, -80, 0)
		audio_player.play()

func toogle_music():
	music_on = not music_on
	
	if not music_on:
		music_player.volume_db = -80
	else:
		music_player.volume_db = clamp(-35 + volume_modifier, -80, 0)

func change_volume(amount):
	volume_modifier = clamp(volume_modifier + amount, MIN_VOLUME, MAX_VOLUME)
	if music_on:
		music_player.volume_db = clamp(-35 + volume_modifier, -80, 0)

func _ready():
	#music_player = AudioStreamPlayer.new()
		
	#self.add_child(music_player)
	#music_player.stream = load("res://Resources/Sound/Music/Jim Hall - Heartache.mp3")
	#music_player.volume_db = -35
	#play("res://Resources/Sound/Music/Jim Hall - Heartache.mp3", -35)
	#music_player.play()
	pass
