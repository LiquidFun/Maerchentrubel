extends Node2D

var current_pos = 0
var max_cycle = 4

var cycle = {
	1: [@"Page1", @"Page2"],
	2: [@"Page3", @"Page4"],
	3: [@"Page5", @"Page6"],
	4: [@"Page7", @"Page8"]
}

var music = null


func _ready():
	music = AudioManager.play("Music/mainmenu.ogg", true, -5)
	for i in max_cycle:
		if i in [0]:
			_on_Next_button_up()
			get_node(cycle[i+1][0]).get_node("AnimationPlayer").play("ShowText")
		else:
			break


func _on_Next_button_up():
	if current_pos >= max_cycle:
		AudioManager.play("Sfx/click.ogg")
		return
	AudioManager.play("Sfx/page_new.ogg")
	current_pos += 1
	for p in cycle[current_pos]:
		get_node(p).show()


func _on_Previous_button_up():
	if current_pos <= 1:
		AudioManager.play("Sfx/click.ogg")
		return
	AudioManager.play("Sfx/page_new.ogg")
	for p in cycle[current_pos]:
		get_node(p).hide()
	current_pos -= 1


func _on_Button_button_up():
	music.stop()
	get_tree().change_scene("res://Scenes/Levels/LevelRedcap.tscn")
