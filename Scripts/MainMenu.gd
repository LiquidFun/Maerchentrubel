extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var music = null

# Called when the node enters the scene tree for the first time.
func _ready():
	music = AudioManager.play("res://Resources/Sound/Music/mainmenu.ogg", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_button_up():
	music.stop()
	AudioManager.play("res://Resources/Sound/Sfx/page_new.ogg")
	get_tree().change_scene("res://Scenes/Book/book.tscn")
