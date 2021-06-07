extends Area2D

export var button_timer = 10

var state = 1
var gate
var pressing = 0

func _ready():
	gate = get_parent().get_parent()

func _on_Button_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("movable"):
		pressing +=1
		if not $Timer.is_stopped():
			$Timer.stop()
		$AnimatedSprite.animation = "on"
		self.state = 0
		AudioManager.play("res://Resources/Sound/Sfx/click.ogg")
		if body.is_in_group("Player"):
			StoryManager.play("tritt_auf_schalter")
		elif body.is_in_group("movable"):
			StoryManager.play("blockiert_schalter")
		gate.button_changed()
	
func _on_Button_body_exited(body):
	if body.is_in_group("Player") or body.is_in_group("movable"):
		pressing -= 1
		if pressing == 0:
			$Timer.wait_time = button_timer
			$Timer.start()

func _on_Timer_timeout():
	$Timer.stop()
	$AnimatedSprite.animation = "off"
	self.state = 1
	AudioManager.play("res://Resources/Sound/Sfx/click.ogg")
	StoryManager.play("tritt_an_tor")
	gate.button_changed()
