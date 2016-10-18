
extends Sprite

signal bullet_hit
var screen_size

var bullet = preload("res://scenes/bullet2.tscn")
var player_speed = 200
var bullet_speed = 1000

var bullet_array = []
var direction_array = []
      
func _ready():
	screen_size = get_viewport_rect().size
	connect("bullet_hit", self.get_parent(), "hit")
	set_process(true)
	
func _process(delta):
	self.look_at(get_global_mouse_pos())

	if(Input.is_action_pressed("fire_1")):
		fire(delta)
	move(delta)


	var bullet_vazio = false

	for i in range(bullet_array.size()):
		var pos = bullet_array[i].get_pos()
		pos += direction_array[i] * bullet_speed * delta
		bullet_array[i].move_to(pos)

	for b in bullet_array:
		var my_pos = b.get_pos()
		if (my_pos.y < 0 or my_pos.y > screen_size.y or my_pos.x < 0 or my_pos.x > screen_size.x) :
			direction_array.remove(bullet_array.find(b))
			bullet_array.remove(bullet_array.find(b))
			b.queue_free()

var last_fire_msec = 0
func fire(delta):
	var fire_rate = 80
	if (OS.get_ticks_msec() - last_fire_msec < fire_rate):
		return
	
	last_fire_msec = OS.get_ticks_msec()
	var instance = bullet.instance()
	instance.set_name("bullet")
	
	var rotation = self.get_rot()
	var direction = Vector2(sin(rotation), cos(rotation))
	var distance_from_me = 20
	var bullet_pos = self.get_pos() + direction * distance_from_me
	
	instance.set_pos(bullet_pos)
	instance.set_rot(rotation + 1 * PI)
	instance.player = self
	instance.damage = 5

	bullet_array.push_back(instance)
	direction_array.push_back(direction)
	
	get_parent().add_child(instance)
	pass
	
func move(delta):
	var pos 
	if (Input.is_action_pressed("ui_up")):
		pos = get_pos()
		pos.y -= player_speed * delta
		set_pos(pos)
		
	
	if (Input.is_action_pressed("ui_down")):
		pos = get_pos()
		pos.y += player_speed * delta
		set_pos(pos)
	
	if (Input.is_action_pressed("ui_left")):
		pos = get_pos()
		pos.x -= player_speed * delta
		set_pos(pos)
	
	if (Input.is_action_pressed("ui_right")):
		pos = get_pos()
		pos.x += player_speed * delta
		set_pos(pos)
		
func hit(bullet):
	direction_array.remove(bullet_array.find(bullet))
	bullet_array.remove(bullet_array.find(bullet))
	bullet.queue_free()
	
	