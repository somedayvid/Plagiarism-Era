extends Sprite2D

var lit := false
var hasPlant := false:
	get:
		return hasPlant
	set(value):
		hasPlant = value

func _highlight():
	modulate = Color8(0,0,255,255)
func _dehighlight():
	modulate = Color8(255,255,255,255)
