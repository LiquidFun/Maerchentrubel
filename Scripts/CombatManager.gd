extends Node

var combatant_list
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	initCombat()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		process_combat()
	
func initCombat():
	rng.randomize()
	combatant_list = get_tree().get_nodes_in_group("combatant")
	combatant_list.append(get_parent().get_node("Player"))
	for combatant in combatant_list:
		combatant.initiative = rng.randi_range(1,20)
	combatant_list.sort_custom(self, "sortCombatantsByInitiative")

func process_combat():
	for combatant in combatant_list:
		combatant.make_turn()
		

func sortCombatantsByInitiative(a, b):
	if a.initiative > b.initiative:
		return true
	return false
	
func handOverTurnToken():
	pass
	
