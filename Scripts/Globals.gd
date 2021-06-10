extends Node

var checkpoint: Area2D = null
var levels_completed = []
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func new_different_random_index(from, to, previous=null):
	var new_index
	while true:
		new_index = rng.randi_range(from, to)
		if new_index != previous:
			break
	return new_index

func _on_boss_finish(tree):
	levels_completed += [0]
	print("Finished")
	tree.change_scene("res://Scenes/Levels/Book.tscn")

