extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_tutorial = true

var snippets = {
	"prolog": {
		"audio": "narrator_prolog.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"waldrand": { 
		"audio": "narrator_waldrand.ogg",
		"preemtible": true,
		"oneshot": true
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
		"audio": "narrator_rotK50.ogg",
		"preemtible": true 
	},
	"wolf50": { 
		"audio": "narrator_wolf50.ogg",
		"preemtible": true 
	},
	#"wolf_kampf_intro": { 
	#	"audio": "narrator_wolf_kampf_intro.ogg",
	#	"preemtible": true 
	#},
	"wolf_kampf_tutorial": { 
		"audio": "narrator_wolf_kampf_tutorial_steine.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"wolf_tutorial_tot": { 
		"audio": "narrator_wolf_tutorial_tot.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"rotk_tot": { 
		"audio": "narrator_rotK_tot.ogg",
		"preemtible": true
	},
	"teleporter_introduction": { 
		"audio": "narrator_teleporter_introduction.ogg",
		"preemtible": true 
	},
	"endkampf_cutscene": { 
		"audio": "narrator_endkampf_cutscene.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"endkampf_start": { 
		"audio": "narrator_endkampf_start.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"endkampf_wolf_50": { 
		"audio": "narrator_endkampf_start.ogg",
		"preemtible": true 
	},
	"endkampf_wolf_tot": { 
		"audio": "narrator_endkampf_wolf_tot.ogg",
		"preemtible": true 
	},
	"gatter_raetsel_1": { 
		"audio": "narrator_gatter_raetsel_1.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"gatter_raetsel_2": { 
		"audio": "narrator_gatter_raetsel_2.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"gatter_raetsel_3": { 
		"audio": "narrator_gatter_raetsel_3.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"haus_großmutter": { 
		"audio": "narrator_haus_großmutter.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"weg_zu_oma": { 
		"audio": "narrator_weg_zum_haus_der_oma.ogg",
		"preemtible": true,
		"oneshot": true
	},
	"healing_potion": { 
		"audio": "narrator_on_healing_potion_pickup.ogg",
		"preemtible": true,
		"oneshot": true
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
	print("Playing ", playing, " key ", key, " preemt", preemt)
	if playing == null or not playing.is_playing():
		_play(key)
	elif preemt:
		_play(key)
		

func _play(key):
	var audio = ""
	if "random_set" in snippets[key]:
		var i = rng.randi_range(0, len(snippets[key]["random_set"]) - 1)
		audio = snippets[key]["random_set"][i]
	else:
		audio = snippets[key]["audio"]
	print(key, " ", audio)
	if "oneshot" in snippets[key]:
		if snippets[key]["oneshot"]:
			snippets[key]["oneshot"] = false
		else:
			playing = null
			return
	if playing != null:
		playing.stop()
		playing = null
	playing = AudioManager.play("res://Resources/Sound/Narrator/" + audio, false, -4)
	preemt = snippets[key]["preemtible"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
