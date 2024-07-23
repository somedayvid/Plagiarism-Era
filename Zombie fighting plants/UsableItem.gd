extends Sprite2D

var beingHeld := false:
	get:
		return beingHeld
	set(value):
		beingHeld = value
var type = "Item"
var packetRect 
var startingPos := Vector2.ZERO
var hovered := false

func _ready():
	startingPos = global_position

func _process(delta) -> void:
	if Singleton.mouseDown && hovered && !Singleton.holdingSeed:
		beingHeld = true
	if beingHeld:
		global_position = Singleton.mousePos
	if !Singleton.mouseDown && beingHeld:
		global_position = startingPos
		beingHeld = false

func _on_area_2d_area_entered(area):
	if area.type == "Cursor":
		hovered = true
	if area.type == "Plant" && area.thirsty:
		area.removeAffliction()

func _on_area_2d_area_exited(area):
	if area.type == "Cursor":
		hovered = false
