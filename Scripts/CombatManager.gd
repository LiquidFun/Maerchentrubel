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
var prev_player_position



# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	rng.randomize()
	
func prepare_combatant(combatant, as_type):
	if as_type == "Friendlies":
		prev_player_position = combatant.position
	combatant.position = battle_scene.get_node(as_type).position
	combatant.scale = Vector2(5, 5)
	combatant.z_index = 1
	var sprite = combatant.get_node("AnimatedSprite")
	sprite.flip_h = (as_type == "Enemy")
	sprite.play("idle")
	
func unprepare_combatant(combatant, as_type):
	combatant.position = prev_player_position
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
		player.position = Vector2(0, 0)
		BattleGlobals.friendlies.append(player)
		BattleGlobals.world_scene = get_tree().get_root()
		add_child(battle_scene)
		battle_scene.get_node("Camera2D").current = true
		prepare_combatant(player, "Friendlies")
		prepare_combatant(combatant, "Enemies")
		player.get_node("CollisionShape2D").disabled = true
		player.can_move = false
		# _list = [player, combatant]
		for curr in [player, combatant]:
			#curr.initiative = rng.randi_range(1, 20)
			curr.add_child(preload("res://Scenes/Particles/BloodParticles.tscn").instance())
		#combatant_list.sort_custom(self, "sortCombatantsByInitiative")

func handle_combat_if_in_combat():
	if in_combat:
		if turn == "player":
			if Input.is_action_just_pressed("ui_accept"):
				timer = Timer.new()
				timer.set_wait_time(0.5)
				timer.autostart = true
				self.add_child(timer)
				timer.start()
				battle_scene.get_node("EnemiesLabel").text = player.make_turn(combatant)
				turn = "combatant"
		elif turn == "combatant":
			turn = ""
			yield(timer, "timeout")
			timer.queue_free()

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
	
