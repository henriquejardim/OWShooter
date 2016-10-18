
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var life = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_parent().get_node("hp").set_text("HP: %s" % str(life))
	set_process(true)

func hit(bullet):
	life -= bullet.damage
	bullet.player.hit(bullet)
	if (life < 0):
		dead()
	
func _process(delta):
	get_parent().get_node("hp").set_text("HP: %s" % str(life))

func dead():
	get_parent().dead(self)


