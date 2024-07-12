extends Area2D

func _ready():
	pass # Replace with function body.
	

func _process(delta):
	global_position = Vector2(get_viewport().get_mouse_position().x - 40,get_viewport().get_mouse_position().y - 52)
