extends KinematicBody2D

signal hit1
signal hit2
signal damage1
signal damage2
signal getdamage1
signal getdamage2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 500
var angle=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass#rotation=angle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

func _physics_process(delta):
	var velocity = Vector2.ZERO
	velocity = Vector2.UP.rotated(rotation) * speed
	move_and_slide(velocity * delta)
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		var collider:KinematicBody2D = collision.collider
		# if not is_instance_valid(collider):
			# continue

		if collider.get_collision_layer_bit(0):
			print("dick")
			queue_free()
			emit_signal("hit1")
			break
		elif collider.get_collision_layer_bit(1):
			queue_free()
			emit_signal("hit2")
			break
		# else:
			# queue_free()
			# break
	#var collision_info = move_and_collide(velocity * delta)
	#if collision_info:
	#	# yield(get_tree().create_timer(0.05), "timeout")
	#	print(get_collision_)
	#	#print(collision_mask)
	#	if(get_collision_layer()==2):
	#		#print("lab1")
	#		emit_signal("hit1")
	#	else:
	#		print("lab2")
	#		emit_signal("hit2")
	#	#queue_free()
	
