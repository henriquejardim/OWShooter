
extends KinematicBody2D
# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var damage = 0
var player 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_fixed_process(true)


func _fixed_process(delta):
	if (is_colliding()):
		if (get_collider() != null and get_collider().has_method("hit")):
			get_collider().hit(self)

