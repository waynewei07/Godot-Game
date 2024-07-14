extends KinematicBody2D

signal damage1
signal damage2
signal damagebottle
signal die2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var healthbar = $healthbar

func hit():
	# print("fuck")
	emit_signal("damage1")

var timer
var timer2

# Called when the node enters the scene tree for the first time.
func _ready():
	var health = 100
	healthbar.init_health(health)
	timer=Timer.new()
	timer.one_shot=true
	add_child(timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed = 400
var angular_speed = PI
var bullet = preload("res://note.tscn")

func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	var moved=false
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
		moved=true
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.UP.rotated(rotation) * speed * -1
		moved=true
	
	var collision_info = move_and_collide(velocity * delta)
		
	if Input.is_action_just_pressed("ui_click_right") and timer.is_stopped():
		timer.start(1)
		for i in range(0,8):
			var new_bullet = bullet.instance()
			new_bullet.position = position
			new_bullet.rotation = rotation+i*deg2rad(360/8)
			new_bullet.connect("hit1", self , "hit")
			get_tree().root.add_child(new_bullet)
		yield(get_tree().create_timer(0.2), "timeout")
		for i in range(0,8):
			var new_bullet = bullet.instance()
			new_bullet.position = position
			new_bullet.rotation = rotation+i*deg2rad(360/8)
			new_bullet.connect("hit1", self , "hit")
			get_tree().root.add_child(new_bullet)
		yield(get_tree().create_timer(0.2), "timeout")
		for i in range(0,8):
			var new_bullet = bullet.instance()
			new_bullet.position = position
			new_bullet.rotation = rotation+i*deg2rad(360/8)
			new_bullet.connect("hit1", self , "hit")
			get_tree().root.add_child(new_bullet)
		yield(get_tree().create_timer(0.2), "timeout")

func _on_player_damage2():
	healthbar._set_health(healthbar.health-10)
	if healthbar.health<=0 :
		emit_signal("die2")
		queue_free()

func _on_player_damagebottle():
	healthbar._set_health(healthbar.health-10)
	if healthbar.health<=0 :
		emit_signal("die2")
		queue_free()
