extends Area2D

func _on_Checkpoint_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if Globals.checkpoint != null:
			Globals.checkpoint.deactivate()
		activate()
		
func activate():
	$Particles.emitting = true
	Globals.checkpoint = self
	
func deactivate():
	$Particles.emitting = false

