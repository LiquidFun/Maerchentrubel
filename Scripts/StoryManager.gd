extends Node

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
		"audio": "narrator_on_healing_potion_pick_up.ogg",
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

func _ready():
	rng.randomize()
	
	
func play(key):
	print("Playing ", playing, " key ", key, " preemt", preemt)
	if playing == null or not playing.is_playing() or preemt:
		return _play(key)
		

func _play(key):
	var audio = ""
	if "random_set" in snippets[key]:
		var i = rng.randi_range(0, len(snippets[key]["random_set"]) - 1)
		audio = snippets[key]["random_set"][i]
	else:
		audio = snippets[key]["audio"]
	if "oneshot" in snippets[key]:
		if snippets[key]["oneshot"]:
			snippets[key]["oneshot"] = false
		else:
			return null
	if playing != null:
		# Stop does not emit finished, so this abomination is tried instead
		playing.seek(playing.stream.get_length() - 0.05)
		yield(get_tree().create_timer(0.2), "timeout")
	playing = AudioManager.play("Narrator/" + audio, false, 0)
	preemt = snippets[key]["preemtible"]
	return playing
