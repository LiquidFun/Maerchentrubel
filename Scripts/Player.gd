extends KinematicBody2D

export var turn_speed = 3
export var tile_size = 16
export var tween_speed = 5.0
export var attack_damage_range = 20
export var armor = 15
export var hit_points = 100
export var speed = 3000
export var can_move = true
export var light_multiplier = 1

onready var nav = get_parent().get_parent()

onready var ray = $RayCast2D
onready var tween = $Tween
onready var animated_sprite = $AnimatedSprite

signal health_changed

var path = PoolVector2Array()

var rng = RandomNumberGenerator.new()

var inputs = {
	"ui_down": Vector2(0, 1),
	"ui_up": Vector2(0, -1),
	"ui_left": Vector2(-1, 0),
	"ui_right": Vector2(1, 0),
}

var has_reached_50 = false

func _ready():
	rng.randomize()

func move(velocity, delta):
	# apply movement and detect collision
	if can_move:
		if velocity.length() > 1:
			velocity = velocity.normalized()
		velocity *= speed * delta
		self.move_and_slide(velocity, Vector2.UP)
		
		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if collision.collider.is_in_group("movable"):
				collision.collider.move_and_slide(-collision.normal * 10)
				
		if velocity.length() > 0:
			animated_sprite.play("walking_basket")
			$FootDust.emitting = true
		else:
			animated_sprite.play("idle")
			$FootDust.emitting = false
		if velocity.x < 0:
			animated_sprite.flip_h = true
		if velocity.x > 0:
			animated_sprite.flip_h = false

func make_turn(target):
	animated_sprite.play("idle")
	$FootDust.emitting = false
	return make_attack(target)

func make_attack(target):
	var to_hit = rng.randi_range(333, 4330)
	var damage = rng.randi_range(5, attack_damage_range)
	animated_sprite.play("attack_basket")
	AudioManager.play("res://Resources/Sound/Sfx/basket_punch.ogg")
	return target.receive_attack(to_hit, damage)
	
func heal():
	add_hit_points(1000)
	has_reached_50 = false
	
func add_hit_points(hp):
	self.hit_points = clamp(self.hit_points + hp, 0, 100)
	emit_signal("health_changed", self.hit_points)

func receive_attack(to_hit, damage):
	var status
	if to_hit >= armor:
		add_hit_points(-damage)
		var blood = preload("res://Scenes/Particles/BloodParticles.tscn").instance()
		add_child(blood)
		blood.set_emitting(true)
		status = str(damage / 10.0) + " Schaden!"
		if self.hit_points <= 0:
			self.die()
			status = "Gestorben!"
	else:
		status = "Verfehlt!"
	print(status)
	if hit_points <= 50 and not has_reached_50:
		StoryManager.play("rotk50")
		has_reached_50 = true
	return status

func die():
	var death = preload("res://Scenes/Particles/DeathParticles.tscn").instance()
	self.add_child(death)
	death.scale.x = 0.1
	death.scale.y = 0.1
	death.set_emitting(true)
	StoryManager.play("rotk_tot")
	can_move = false
	yield(get_tree().create_timer(2), "timeout")
	can_move = true
	if Globals.checkpoint == null:
		get_tree().change_scene("res://Scenes/Levels/LevelRedcap.tscn")
	else:
		heal()
		self.global_position = Globals.checkpoint.global_position

func _process(delta):
	var velocity = Vector2(0, 0)
	for i in inputs.keys():
		if Input.get_action_strength(i):
			velocity += inputs[i]
	move(velocity, delta)
