extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	yield(get_tree().create_timer(2), "timeout")
	set_paused(true)


func _on_Button_button_down():
	print("tsaoxixue")
	paused=false
