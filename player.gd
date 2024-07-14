extends KinematicBody2D

signal damage1
signal damage2
signal damagebottle
signal die


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var healthbar = $healthbar

func hit():
	emit_signal("damage2")

func hitbottle():
	emit_signal("damagebottle")
	
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	var health = 100
	healthbar.init_health(health)
	timer=Timer.new()
	timer.one_shot=true
	add_child(timer)

var speed = 400
var angular_speed = PI
var weiwei = preload("res://bullet.tscn")
var bottle = preload("res://bottle.tscn")


func _physics_process(delta):
	
	var direction = 0
	if Input.is_action_pressed("ui_a"):
		direction = -1
	if Input.is_action_pressed("ui_d"):
		direction = 1
	
	rotation += angular_speed * direction * delta
	var moved=false
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_w"):
		velocity = Vector2.UP.rotated(rotation) * speed
		moved=true
	if Input.is_action_pressed("ui_s"):
		velocity = Vector2.UP.rotated(rotation) * speed * -1
		moved=true
		
	# if moved==false:
		# healthbar._set_health(healthbar.health-1*delta)
		
	var collision_info = move_and_collide(velocity * delta)
		
	if Input.is_action_just_pressed("ui_q") and timer.is_stopped():
		timer.start(1)
		var new_dick = bottle.instance()
		new_dick.position = position
		new_dick.rotation = rotation
		new_dick.connect("hit3", self , "hitbottle")
		get_tree().root.add_child(new_dick)

func _on_player2_damage1():
	healthbar._set_health(healthbar.health-10)
	if healthbar.health<=0 :
		emit_signal("die")
		queue_free()
