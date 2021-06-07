extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var music = null

# Called when the node enters the scene tree for the first time.
func _ready():
	music = AudioManager.play("Music/mainmenu.ogg", true, -1)
	$Tween.connect("tween_all_completed", self, "_on_tween_completed")

func _on_tween_completed():
	music.stop()
	AudioManager.play("Sfx/page_new.ogg")
	get_tree().change_scene("res://Scenes/Levels/Book.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_button_up():
	$Tween.interpolate_property(music, "volume_db", music.volume_db, -80, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($ColorRect, "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Button2_button_up():
	get_tree().quit()
