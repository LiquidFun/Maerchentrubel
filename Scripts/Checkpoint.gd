extends Area2D

func _on_Checkpoint_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		Globals.checkpoint = self

