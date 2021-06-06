extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var audio_key = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Node2D_body_entered(body):
	if body.name == "Player" and audio_key != "":
			StoryManager.play(audio_key)
