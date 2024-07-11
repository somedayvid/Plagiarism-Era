extends Sprite2D

var lit := false

func _highlight():
	modulate = Color8(0,0,255,255)
func _dehighlight():
	modulate = Color8(255,255,255,255)
