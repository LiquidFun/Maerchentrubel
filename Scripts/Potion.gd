extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var player
export var snow_particles_amount = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]

func dist(p1, p2):
	return abs(p1.get_global_position().distance_to(p2.get_global_position()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dist(player, self) < 20:
		player.heal()
		var particles = preload("res://Scenes/Particles/PotionParticles.tscn").instance()
		get_parent().add_child(particles)
		particles.global_position = self.global_position
		particles.set_emitting(true)
		self.queue_free()
