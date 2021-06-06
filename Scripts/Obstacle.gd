extends KinematicBody2D

var speed
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 5000000

func _process(delta):
	var velocity = Vector2(0,0)
	if velocity.length() > 1:
		velocity = velocity.normalized()
	velocity *= speed * get_process_delta_time()
	var collision = move_and_collide(velocity)
	#if collision:
	#	collision.collider.move_and_collide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
