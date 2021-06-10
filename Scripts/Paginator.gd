extends Node2D

var current_page = 0
var max_cycle = 4

onready var cycle = {
	1: [$Page1, $Page2],
	2: [$Page3, $Page4],
	3: [$Page5, $Page6],
	4: [$Page7, $Page8]
}

var music = null


func _ready():
	for page_index in cycle:
		for page in cycle[page_index]:
			page.hide()
	music = AudioManager.play("Music/mainmenu.ogg", true, -5)
	for index in max_cycle:
		if index in Globals.levels_completed:
			_on_Next_button_up()
			cycle[index+1][0].get_node("AnimationPlayer").play("ShowText")
		else:
			break


func _on_Next_button_up():
	if current_page >= max_cycle:
		AudioManager.play("Sfx/click.ogg")
		return
	AudioManager.play("Sfx/page_new.ogg")
	current_page += 1
	for page in cycle[current_page]:
		page.show()


func _on_Previous_button_up():
	if current_page <= 1:
		AudioManager.play("Sfx/click.ogg")
		return
	AudioManager.play("Sfx/page_new.ogg")
	for page in cycle[current_page]:
		page.hide()
	current_page -= 1


func _on_Button_button_up():
	music.stop()
	get_tree().change_scene("res://Scenes/Levels/LevelRedcap.tscn")
