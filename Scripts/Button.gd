extends Area2D

export var button_timer = 10

var state = 1
var gate
var pressing = 0

func _ready():
	gate = get_parent().get_parent()

func _on_Button_body_entered(body):
	pressing +=1
	if not $Timer.is_stopped():
		$Timer.stop()
	$AnimatedSprite.animation = "on"
	self.state = 0
	gate.button_changed()
	
func _on_Button_body_exited(body):
	pressing -= 1
	if pressing == 0:
		$Timer.wait_time = button_timer
		$Timer.start()

func _on_Timer_timeout():
	$Timer.stop()
	$AnimatedSprite.animation = "off"
	self.state = 1
	gate.button_changed()
