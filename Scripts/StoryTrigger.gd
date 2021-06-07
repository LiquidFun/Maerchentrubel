extends Area2D

export var audio_key = ""

func _on_audio_finish():
	$AnimatedSprite.play("idle")

func _on_Node2D_body_entered(body):
	if body.name == "Player" and audio_key != "":
		var audio_player = StoryManager.play(audio_key)
		if audio_player != null:
			audio_player.connect("finished", self, "_on_audio_finish")
			$AnimatedSprite.play("sound")
