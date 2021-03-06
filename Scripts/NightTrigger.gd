extends Area2D

var player
export var night_color = Color("#222222")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]

func dist(p1, p2):
	return abs(p1.get_global_position().distance_to(p2.get_global_position()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dist(player, self) < 20:
		get_node("AnimationPlayer").play("MakeItNight")
