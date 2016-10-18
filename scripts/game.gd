
extends Node2D

var enemy = preload("res://scenes/Enemy.tscn")

func _ready():
	set_process(true)
	set_fixed_process(true)
	
	
func _process(delta):
	pass

func _fixed_process(delta):
	var enemy_hp = get_node("hp")
	get_node("Label").set_text("FPS: %s" % str(OS.get_frames_per_second()))
	
	var player = get_node("Player")
	var enemy = get_node("Enemy")
	
	if (enemy != null):
		enemy.look_at(player.get_pos())
		var rotation = enemy.get_rot()
		var direction = Vector2(sin(rotation), cos(rotation))
		var enemy_pos = enemy.get_pos() 
		enemy_pos += direction * 80 * delta
		enemy.move_to(enemy_pos)
		var label_pos = enemy.get_pos()
		label_pos.y -= 50
		label_pos.x -= 25
		enemy_hp.set_pos(label_pos)
	
	
func dead (dead_node):
	dead_node.queue_free()
	remove_child(dead_node)
	var enemy_instance = enemy.instance()
	enemy_instance.set_name("Enemy")
	add_child(enemy_instance)
	enemy_instance.set_pos(dead_node.get_pos())
	
	
