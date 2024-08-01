extends Node2D

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
	if Singleton.mouseDown && hovered && !Singleton.holdingItem:
		beingHeld = true
		global_position = get_tree().root.get_child(1).get_node("CursorTemp").global_position
		self.reparent(get_tree().root.get_child(1).get_node("Hand"))
		Singleton.holdingItem = true
	if beingHeld:
		global_position = Singleton.mousePos
	if !beingHeld:
		global_position = startingPos
		self.reparent(get_tree().root.get_child(1).get_node("LawnScene").get_node("UsableItems"))

func _on_area_2d_area_entered(area):
	if area.type == "Cursor":
		hovered = true

func _on_area_2d_area_exited(area):
	if area.type == "Cursor":
		hovered = false
