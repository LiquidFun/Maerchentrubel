extends Node

var combatant_list
var player
var combatant
var rng = RandomNumberGenerator.new()
var in_combat = false
var battle_scene
var players_turn = true
var timer
var turn = "player"
var attack_time
var prev_player_position



# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	rng.randomize()
	
func prepare_combatant(combatant, as_type):
	combatant.position = battle_scene.get_node(as_type).position
	combatant.scale = Vector2(5, 5)
	combatant.z_index = 1
	var sprite = combatant.get_node("AnimatedSprite")
	sprite.flip_h = (as_type == "Enemy")
	sprite.play("idle")
	
func unprepare_combatant(combatant, as_type):
	if combatant != null:
		combatant.scale = Vector2(1, 1)
		combatant.z_index = 0
		var sprite = combatant.get_node("AnimatedSprite")
		sprite.flip_h = (as_type == "Enemy")
		sprite.play("idle")
	
func dist(p1, p2):
	return abs(p1.get_global_position().distance_to(p2.get_global_position()))

func get_combatant_if_exists():
	for combatant in get_tree().get_nodes_in_group("combatant"):
		if dist(player, combatant) < 12:
			return combatant
	return null
	
func start_combat_if_possible():
	var possible_combatant = get_combatant_if_exists()
	if possible_combatant != null and not in_combat:
		combatant = possible_combatant
		in_combat = true
		battle_scene = preload("res://Scenes/Levels/Battle.tscn").instance()
		prev_player_position = player.position
		BattleGlobals.friendlies.append(player)
		BattleGlobals.world_scene = get_tree().get_root()
		add_child(battle_scene)
		battle_scene.get_node("Camera2D").current = true
		prepare_combatant(player, "Friendlies")
		prepare_combatant(combatant, "Enemies")
		player.get_node("CollisionShape2D").disabled = true
		player.can_move = false
		
func end_combat():
	unprepare_combatant(player, "Friendlies")
	unprepare_combatant(combatant, "Enemies")
	player.position = prev_player_position
	battle_scene.queue_free()
	battle_scene = null
	in_combat = false
	player.get_node("Camera2D").current = true
	player.get_node("CollisionShape2D").disabled = false
	player.can_move = true

func handle_combat_if_in_combat():
	if in_combat:
		if turn == "player":
			if combatant == null:
				end_combat()
				return
			if Input.is_action_just_pressed("ui_accept"):
				attack_time = OS.get_unix_time()
				var status = player.make_turn(combatant)
				battle_scene.get_node("EnemiesLabel").text = status
				if "dead" in status.to_lower():
					combatant = null
				turn = "combatant"
		elif turn == "combatant":
			if attack_time + 0.2 < OS.get_unix_time():
				if combatant != null and battle_scene != null and in_combat:
					battle_scene.get_node("FriendliesLabel").text = combatant.make_turn(player)
				turn = "player"

func _process(delta):
	start_combat_if_possible()
	handle_combat_if_in_combat()

func sortCombatantsByInitiative(a, b):
	if a.initiative > b.initiative:
		return true
	return false
	
func handOverTurnToken():
	pass
	
