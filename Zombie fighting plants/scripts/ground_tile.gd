extends Sprite2D

var lit := false:
	get:
		return lit
var hasPlant := false:
	get:
		return hasPlant
	set(value):
		hasPlant = value

func highlight():
	self_modulate = Color8(0,0,255,255)
	lit = true
func dehighlight():
	self_modulate = Color8(255,255,255,255)
	lit = false
