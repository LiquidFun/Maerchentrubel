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
var attack_time = 0
var prev_player_position
var stone = null
var stone_set_time = null
var first_cycle = true

export var stone_press_time = 0.9
export var enemy_attack_delay = 1
export var after_enemy_attack_delay = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	rng.randomize()
	
func prepare_combatant(combatant, as_type):
	combatant.global_position = battle_scene.get_node(as_type).global_position
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
		if dist(player, combatant) < 20:
			return combatant
	return null
	
func start_combat_if_possible():
	var possible_combatant = get_combatant_if_exists()
	if possible_combatant != null and not in_combat:
		combatant = possible_combatant
		in_combat = true
		first_cycle = true
		stone_set_time = null
		battle_scene = preload("res://Scenes/Levels/Battle.tscn").instance()
		battle_scene.modulate = owner.modulate
		prev_player_position = player.global_position
		add_child(battle_scene)
		battle_scene.get_node("Camera2D").current = true
		prepare_combatant(player, "Friendlies")
		prepare_combatant(combatant, "Enemies")
		player.get_node("CollisionShape2D").disabled = true
		player.can_move = false
		
func end_combat():
	unprepare_combatant(player, "Friendlies")
	unprepare_combatant(combatant, "Enemies")
	player.global_position = prev_player_position
	battle_scene.queue_free()
	battle_scene = null
	in_combat = false
	player.get_node("Camera2D").current = true
	player.get_node("CollisionShape2D").disabled = false
	player.can_move = true
	
func handle_stones():
	if stone == null:
		var stone_index = rng.randi_range(1, 7)
		if stone_set_time == null:
			stone_index = 3
			stone_set_time = OS.get_unix_time() + 154656465
		else:
			stone_set_time = OS.get_unix_time() 
			if first_cycle:
				battle_scene.get_node("TutorialAnimation").play("HideTutorial")
				first_cycle = false
		stone = battle_scene.get_node("BL" + str(stone_index))
		var ap = stone.get_node("AnimationPlayer")
		ap.play("LightOn")
	elif stone_set_time + stone_press_time < OS.get_unix_time():
		var ap = stone.get_node("AnimationPlayer")
		ap.play("Miss")
		stone = null
		attack_time = OS.get_unix_time()
		turn = "combatant"
	else:
		var ap = stone.get_node("AnimationPlayer")
		for i in range(1, 8):
			if Input.is_action_pressed("ui_" + str(i)):
				var status = "Verfehlt!"
				attack_time = OS.get_unix_time()
				if str(i) in stone.name:
					ap.play("Hit")
					status = player.make_turn(combatant)
				else:
					ap.play("Miss")
				battle_scene.get_node("EnemiesLabel").text = status
				battle_scene.get_node("EnemyAnimations").play("EnemiesShow")
				if "tot" in status.to_lower():
					combatant = null
				turn = "combatant"
				stone = null
				return

func handle_combat_if_in_combat():
	if in_combat:
		if turn == "player":
			if combatant == null:
				end_combat()
				return
			if attack_time + after_enemy_attack_delay < OS.get_unix_time():
				handle_stones()
		elif turn == "combatant":
			if attack_time + enemy_attack_delay < OS.get_unix_time():
				if combatant != null and battle_scene != null and in_combat:
					battle_scene.get_node("FriendliesLabel").text = combatant.make_turn(player)
					battle_scene.get_node("FriendlyAnimations").play("FriendliesShow")
					
				attack_time = OS.get_unix_time()
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
	
