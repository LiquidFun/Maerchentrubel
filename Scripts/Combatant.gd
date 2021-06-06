extends Node
export var hit_points = 100
export var turn_speed = 1
export var attack_damage_range = 10
export var attack_range = 1
export var aggro_range = 5
export var armor = 5
export var in_combat = false
export var initiative = 0
var rng = RandomNumberGenerator.new()

signal health_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("combatant")
	rng.randomize()
	
func make_turn(target):
	return make_attack(target)
	
func make_attack(target):
	print(self.name +" makes attack against " +str(target.name))
	var to_hit = rng.randi_range(1,20)
	var damage = rng.randi_range(3,attack_damage_range)
	return target.receive_attack(to_hit, damage)
	
func receive_attack(to_hit, damage):
	var status
	if to_hit >= armor:
		self.hit_points -= damage
		emit_signal("health_changed", hit_points)
		var blood = preload("res://Scenes/Particles/BloodParticles.tscn").instance()
		add_child(blood)
		blood.set_emitting(true)
		status = str(damage / 10.0) + " Schaden!"
		if self.hit_points <= 0:
			var death = preload("res://Scenes/Particles/DeathParticles.tscn").instance()
			get_parent().add_child(death)
			death.position = self.position
			death.z_index = 1
			death.set_emitting(true)
			status = "Ist tot!"
			self.die()
		print(self.name + " receives " + status)
	else:
		status = "Verfehlt!"
	print(status)
	return status

func die():
	self.queue_free()

