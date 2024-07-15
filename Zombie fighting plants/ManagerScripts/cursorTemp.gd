extends Area2D

var item

func _ready():
	pass # Replace with function body.
	

func _process(delta):
	global_position = Singleton.mousePos
	if Input.is_action_pressed("mouseAction"):
		if item.type == "Sun":
			Singleton.gainSun(item.sunValue)
			item.collision_layer = 0
			item.collision_mask = 0

func _on_body_entered(area):
	item = area

func _on_body_exited(body):
	pass
