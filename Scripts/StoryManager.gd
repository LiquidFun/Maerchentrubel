extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var snippets = {
	"teleport": { "audio": "res://Resources/Sound/Music/background.ogg", "preemtible": true },
	"prologue": { "audio": "res://Resources/Sound/Music/mainmenu.ogg", "preemtible": false },
}

var playing = null
var preemt = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func play(key):
	if playing == null:
		playing = AudioManager.play(snippets[key]["audio"])
		preemt = snippets[key]["preemtible"]
	elif preemt:
		playing.stop()
		playing = AudioManager.play(snippets[key]["audio"])
		preemt = snippets[key]["preemtible"]
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
