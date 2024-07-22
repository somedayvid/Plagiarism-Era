extends Area2D

var item
var type = "Cursor":
	get:
		return type

func _process(delta):
	global_position = Singleton.mousePos
	if Input.is_action_pressed("mouseAction") && item != null:
		if item.type == "Sun":
			Singleton.gainSun(item.sunValue)
			item.call_deferred("queue_free")
			item = null
		else:
			pass

func _on_body_entered(area):
	item = area

func _on_body_exited(body):
	item = null
