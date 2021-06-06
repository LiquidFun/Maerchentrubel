extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var snippets = {
	"prolog": {
		"audio": "narrator_prolog.ogg",
		"preemtible": false 
	},
	"waldrand": { 
		"audio": "narrator_waldrand.ogg",
		"preemtible": false 
	},
	"blockiert_schalter": {
		"audio": "narrator_blockiert_schalter_mit_stein.ogg",
		"preemtible": true,
		"oneshot": true 
	},
	"tritt_an_tor": {
		"audio": "narrator_tritt_an_tor_heran.ogg",
		"preemtible": true, 
		"oneshot": true 
	},
	"tritt_auf_schalter": { 
		"audio": "narrator_tritt_auf_schalter.ogg",
		"preemtible": true, 
		"oneshot": true 
	},
	"weg_vom_haus": { 
		"audio": "narrator_weg_vom_haus_weg.ogg",
		"preemtible": true, 
		"oneshot": true 
	},
	"rotk50": { 
		"audio": "narrator_rotk50.ogg",
		"preemtible": false 
	},
	"wolf50": { 
		"audio": "narrator_wolf50.ogg",
		"preemtible": false 
	},
	"wolf_kampf_intro": { 
		"audio": "narrator_wolf_kampf_intro.ogg",
		"preemtible": false 
	},
	"wolf_kampf_tutorial": { 
		"audio": "narrator_wolf_kampf_tutorial_steine.ogg",
		"preemtible": false 
	},
	"wolf_tot": { 
		"audio": "narrator_wolf_tutorial_tot.ogg",
		"preemtible": false 
	},
	"teleporter_introduction": { 
		"audio": "narrator_teleporter_introduction.ogg",
		"preemtible": false 
	},
	"teleport": { 
		"random_set": [
			"narrator_on_teleporter_teleport_1.ogg", "narrator_on_teleporter_teleport_2.ogg",
			"narrator_on_teleporter_teleport_3.ogg", "narrator_on_teleporter_teleport_4.ogg",
			"narrator_on_teleporter_teleport_5.ogg", "narrator_on_teleporter_teleport_6.ogg",
			"narrator_on_teleporter_teleport_7.ogg"
		], 
		"preemtible": true
	}
}

var playing = null
var preemt = true

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass

func play(key):
	if playing == null:
		_play(key)
	elif preemt:
		playing.stop()
		_play(key)
		

func _play(key):
	var audio = ""
	if "random_set" in snippets[key]:
		var i = rng.randi_range(0, len(snippets[key]["random_set"]) - 1)
		audio = snippets[key]["random_set"][i]
	else:
		audio = snippets[key]["audio"]
	if "oneshot" in snippets[key]:
		if not snippets[key]["oneshot"]:
			return
		else:
			snippets[key]["oneshot"] = false
	playing = AudioManager.play("res://Resources/Sound/Narrator/" + audio, false, -4)
	preemt = snippets[key]["preemtible"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
