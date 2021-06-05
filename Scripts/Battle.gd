extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _process(delta):
	pass 

func _ready():
	$FriendliesLabel.text = "200"
	#print(get_children())

#func _ready():
#	for friendly in BattleGlobals.friendlies:
#		print("Adding " + str(friendly))
#		$Friendlies.add_child(friendly)
#	for enemy in BattleGlobals.enemies:
#		print("Adding " + str(enemy))
#		$Enemies.add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
