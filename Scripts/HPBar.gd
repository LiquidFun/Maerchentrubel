extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

const max_health = 100

func update_bars(player_health):
	var bars = get_child_count()
	for i in bars:
		if player_health > max_health / bars * (i + 0.5):
			get_child(i).play("full")
		elif player_health > max_health / bars * i:
			get_child(i).play("half")
		else:
			get_child(i).play("empty")


func _on_Player_health_changed(player_health) -> void:
	update_bars(player_health)
	print("Health changed!")
