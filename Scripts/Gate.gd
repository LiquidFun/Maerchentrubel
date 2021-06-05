extends KinematicBody2D

var button_list = []
export var combination = "0"
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.connect("animation_finished", self, \
	"on_Animated_Sprite_animation_finished")
	button_list = get_node("Buttons").get_children()

func open_gate():
	if $AnimatedSprite.animation != "open":
		$AnimatedSprite.animation = "opening"
		$AnimatedSprite.play()

func close_gate():
	if $AnimatedSprite.animation != "closed":
		$AnimatedSprite.animation = "closing"
		$AnimatedSprite.play()

func on_Animated_Sprite_animation_finished():
	if $AnimatedSprite.animation == "opening":
		$AnimatedSprite.animation = "open"
		$CollisionShape2D.disabled = true
	elif $AnimatedSprite.animation == "closing":
		$AnimatedSprite.animation = "closed"
		$CollisionShape2D.disabled = false
	$AnimatedSprite.stop()


func button_changed():
	var current_combination = ""
	for button in button_list:
		current_combination += str(button.state)
	if current_combination == combination:
		open_gate()
	else:
		close_gate()
		
