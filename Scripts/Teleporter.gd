extends Area2D

export var teleport_location = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Teleporter_body_entered(body):
	if body.name == "Player":
		print (body.name)
		body.position = teleport_location
