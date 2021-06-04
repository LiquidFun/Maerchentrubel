extends Area2D

export var turn_speed = 3
export var tile_size = 16
export var tween_speed = 3.0

onready var ray = $RayCast2D
onready var tween = $Tween



var inputs = {
	"ui_down": Vector2(0, 1),
	"ui_up": Vector2(0, -1),
	"ui_left": Vector2(-1, 0),
	"ui_right": Vector2(1, 0),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(dir)

func _unhandled_input(event):
	if tween.is_active():
		return
	if turn_speed > 0:
		for i in inputs.keys():
			if event.is_action_released(i):
				move(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		#if Input.is_action_just_pressed("ui_up"):
		#	position.y -= 16
		#if Input.is_action_just_pressed("ui_left"):
		#	position.x -= 16
		#if Input.is_action_just_pressed("ui_right"):
		#	position.x +=16
