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

var initiative = 0
var rng = RandomNumberGenerator.new()

var inputs = {
	"ui_down": Vector2(0, 1),
	"ui_up": Vector2(0, -1),
	"ui_left": Vector2(-1, 0),
	"ui_right": Vector2(1, 0),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func move_tween(newPos):
	tween.interpolate_property(self, "position",
		position, newPos,
		1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	animated_sprite.play("walking_basket")

func move_tween_path(path):
	tween.interpolate_property()

func _on_Tween_tween_completed(object, key):
	animated_sprite.stop()
	if path.size() > 0:
		print("move to " + str(path[0]))
		tween.interpolate_property(self, "position",
			self.position, path[0],
			1.0/tween_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		path.remove(0)
		tween.start()
	
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
	print("make_attack")
	var to_hit = rng.randi_range(333, 4330)
	var damage = rng.randi_range(1, attack_damage_range)
	animated_sprite.play("attack_basket")
	AudioManager.play("res://Resources/Sound/Sfx/basket_punch.ogg")
	return target.receive_attack(to_hit, damage)
	
func heal():
	hit_points = 100
	emit_signal("health_changed", hit_points)

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
			death.position = self.position
			death.set_emitting(true)
			status = "Ist tot!"
			get_tree().change_scene("res://Scenes/Levels/Level_Redcap.tscn")
		print(self.name + " receives " + status)
	else:
		status = "Verfehlt!"
	print(status)
	return status

func die():
	self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# movement with wasd
	var velocity = Vector2(0, 0)
	for i in inputs.keys():
		if Input.get_action_strength(i):
			velocity += inputs[i]
	move(velocity, delta)


		#if Input.is_action_just_pressed("ui_up"):
		#	position.y -= 16
		#if Input.is_action_just_pressed("ui_left"):
		#	position.x -= 16
		#if Input.is_action_just_pressed("ui_right"):
		#	position.x +=16
