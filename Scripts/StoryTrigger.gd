extends Area2D

export var audio_key = ""

func _on_Node2D_body_entered(body):
	if body.name == "Player" and audio_key != "":
			StoryManager.play(audio_key)
