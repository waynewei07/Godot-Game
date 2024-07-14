extends Area2D

signal hit4
signal die

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer
var timer2

# Called when the node enters the scene tree for the first time.
func _ready():
	timer=Timer.new()
	timer.one_shot=true
	add_child(timer)
	timer2=Timer.new()
	timer2.one_shot=true
	add_child(timer2)
	timer2.start(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timer2.is_stopped()):
		emit_signal("die")
		queue_free()
	var targets=self.get_overlapping_bodies()
	for target in targets:
		if(target.get_collision_layer_bit(1) and timer.is_stopped()):
			timer.start(1)
			emit_signal("hit4")
