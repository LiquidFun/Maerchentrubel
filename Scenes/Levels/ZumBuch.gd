extends Button



func _ready() -> void:
	pass 
	

func _on_ZumBuch_button_up() -> void:
	get_tree().change_scene("res://Scenes/Levels/Book.tscn")
