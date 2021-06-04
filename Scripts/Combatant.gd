extends Node
export var hit_points = 999
export var turn_speed = 1
export var attack_damage_range = 6
export var attack_range = 1
export var aggro_range = 5
export var armor = 5
export var in_combat = false
export var initiative = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("combatant")
	rng.randomize()
	
func make_turn():
	make_attack(get_parent().get_node("Player"))
	
func make_attack(target):
	print(self.name +" makes attack against " +str(target.name))
	var to_hit = rng.randi_range(1,20)
	var damage = rng.randi_range(1,attack_damage_range)
	target.receive_attack(to_hit, damage)
	
func receive_attack(to_hit, damage):
	if to_hit >= armor:
		self.hit_points -= damage
		if self.hit_points <= 0:
			self.die()

func die():
	self.queue_free()

