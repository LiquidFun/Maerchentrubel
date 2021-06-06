extends Area2D

export var teleport_location = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	if "TeleporterEncounter" in get_parent().name:
		self.teleport_location = get_parent().teleport_coordinates


func _on_Teleporter_body_entered(body):
	if body.name == "Player":
		print (body.name +" was teleported to " +str(self.teleport_location))
		var particles = preload("res://Scenes/Particles/TeleportParticles.tscn").instance()
		add_child(particles)
		particles.set_emitting(true)
		body.position = teleport_location
