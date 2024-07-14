extends Area2D

signal hit3

var speed = 1000
var angle = 0
var path = 0
var stopped = false

var weiwei = preload("res://poison.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass#rotation=angle

func hit():
	emit_signal("hit3")

func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(stopped):
		return
	var velocity = Vector2.ZERO
	velocity = Vector2.UP.rotated(rotation) * speed
	var prev_position=position
	position += velocity * delta
	path += delta
	# print(path)
	if(path>=0.5):
		var new_dick = weiwei.instance()
		new_dick.position = position
		new_dick.connect("hit4", self , "hit")
		new_dick.connect("die", self , "die")
		get_tree().root.add_child(new_dick)
		stopped = true
		$Sprite.texture = null
		return
		# queue_free()
	var targets=self.get_overlapping_bodies()
	for target in targets:
		if(target.get_collision_layer_bit(1)):
			var new_dick = weiwei.instance()
			new_dick.position = position
			new_dick.connect("hit4", self , "hit")
			new_dick.connect("die", self , "die")
			get_tree().root.add_child(new_dick)
			stopped = true
			$Sprite.texture = null
	
