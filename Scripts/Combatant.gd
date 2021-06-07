extends Node
export var hit_points = 100
export var turn_speed = 1
export var attack_damage_range = 15
export var attack_range = 1
export var aggro_range = 5
export var armor = 5
export var plus_to_hit = 0
var in_combat = false
export var initiative = 0
var rng = RandomNumberGenerator.new()
export var is_endboss = false

var has_reached_50 = false

signal health_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("combatant")
	rng.randomize()

func heal():
	add_hit_points(1000)
	has_reached_50 = false
	
func add_hit_points(hp):
	self.hit_points = clamp(self.hit_points + hp, 0, 100)
	emit_signal("health_changed", self.hit_points)
	
func make_turn(target):
	return make_attack(target)
	
func make_attack(target):
	print(self.name + " makes attack against " + str(target.name))
	var to_hit = rng.randi_range(1, 20) + plus_to_hit
	var damage = rng.randi_range(3, attack_damage_range)
	return target.receive_attack(to_hit, damage)
	
func receive_attack(to_hit, damage):
	var status
	if to_hit >= armor:
		add_hit_points(-damage)
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
	if self.hit_points <= 50 and not has_reached_50:
		if is_endboss:
			StoryManager.play("endkampf_wolf_50")
		else:	
			StoryManager.play("wolf50")
		has_reached_50 = true
	return status
	
func _on_boss_finish():
	get_tree().change_scene("res://Scenes/Levels/Book.tscn")

func die():
	if is_endboss:
		var audio_player = StoryManager.play("endkampf_wolf_tot")
		audio_player.connect("finished", Globals, "_on_boss_finish")
		
		var grandma = preload("res://Scenes/Controllers/Grandma.tscn").instance()
		grandma.position = get_parent().get_node("SpawnGrandma").position
		get_parent().add_child(grandma)

		var hunter = preload("res://Scenes/Controllers/Hunter.tscn").instance()
		hunter.position = get_parent().get_node("SpawnHunter").position
		get_parent().add_child(hunter)
	else:
		StoryManager.play("wolf_tutorial_tot")
	self.queue_free()

