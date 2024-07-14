extends Node2D

signal hit1
signal hit2
signal damage1
signal damage2
signal getdamage1
signal getdamage2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("damage1", self ,  "damage1")
	connect("damage2", self , "damage2")
	
func damage1():
	emit_signal("getdamage1")

func damage2():
	emit_signal("getdamage2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
