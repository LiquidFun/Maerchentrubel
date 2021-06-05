extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_pos = 0
var max_cycle = 4

var cycle = {
	1: [@"Page1", @"Page2"],
	2: [@"Page3", @"Page4"],
	3: [@"Page5", @"Page6"],
	4: [@"Page7", @"Page8"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play("res://Resources/Sound/Music/mainmenu.ogg", true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_button_up():
	if current_pos >= max_cycle:
		AudioManager.play("res://Resources/Sound/Sfx/click.ogg")
		return
	AudioManager.play("res://Resources/Sound/Sfx/page_new.ogg")
	current_pos += 1
	for p in cycle[current_pos]:
		get_node(p).show()
	pass # Replace with function body.


func _on_Previous_button_up():
	if current_pos <= 1:
		AudioManager.play("res://Resources/Sound/Sfx/click.ogg")
		return
	AudioManager.play("res://Resources/Sound/Sfx/page_new.ogg")
	for p in cycle[current_pos]:
		get_node(p).hide()
	current_pos -= 1
	pass # Replace with function body.
