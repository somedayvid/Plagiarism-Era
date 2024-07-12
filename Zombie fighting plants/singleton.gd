extends Node

var mousePos := Vector2.ZERO
var holdingSeed := false:
	set(value):
		holdingSeed = value
	get:
		return holdingSeed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousePos = get_viewport().get_mouse_position()
