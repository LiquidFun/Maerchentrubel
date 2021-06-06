extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var snippets = {
	"prolog": { "audio": "narrator_prolog.ogg", "preemtible": false },
	"waldrand": { "audio": "narrator_waldrand.ogg", "preemtible": false },
	"blockiert_schalter": { "audio": "narrator_blockiert_schalter_mit_stein.ogg", "preemtible": false },
	"tritt_an_tor": { "audio": "narrator_tritt_an_tor_heran.ogg", "preemtible": false },
	"tritt_auf_schalter": { "audio": "narrator_tritt_auf_schalter.ogg", "preemtible": true },
	"weg_vom_haus": { "audio": "narrator_weg_vom_haus_weg.ogg", "preemtible": false }
}

var playing = null
var preemt = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func play(key):
	if playing == null:
		playing = AudioManager.play("res://Resources/Sound/Narrator/" + snippets[key]["audio"], 0)
		preemt = snippets[key]["preemtible"]
	elif preemt:
		playing.stop()
		playing = AudioManager.play("res://Resources/Sound/Narrator/" + snippets[key]["audio"], 0)
		preemt = snippets[key]["preemtible"]
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
