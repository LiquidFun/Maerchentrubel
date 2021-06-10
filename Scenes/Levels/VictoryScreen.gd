extends CenterContainer


func _on_Combatant2_endboss_dead() -> void:
	self.show()
	Globals.levels_completed += [0]
