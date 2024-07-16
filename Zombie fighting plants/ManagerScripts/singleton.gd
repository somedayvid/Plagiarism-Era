extends Node

#mouseStuff
var mousePos := Vector2.ZERO
var holdingSeed := false:
	set(value):
		holdingSeed = value
	get:
		return holdingSeed
var gridPos := Vector2.ZERO
var mouseDown := false
var justPressed := false
var hand : Node2D
var grid : Node2D

#gameStuff
var sunCount := 100

func _ready():
	hand = get_tree().root.get_child(1).get_node("Hand")
	grid = get_tree().root.get_child(1).get_node("Grid")

func _process(delta):
	mouseStuff()

func mouseStuff():
	hasSeed()
	mousePress()
	gridPos = grid.currentMouseGridPos
	mousePos = get_viewport().get_mouse_position()

func mousePress():
	if Input.is_action_pressed("mouseAction"):
		mouseDown = true
	if Input.is_action_just_released("mouseAction"):
		mouseDown = false
		if holdingSeed:
			var heldItem = hand.get_child(0)
			if grid.onGrid && sunCount >= heldItem.sunCost:
				heldItem.global_position = grid.placementGrid[gridPos.x][gridPos.y].global_position
				heldItem.gridPos = gridPos
				heldItem.beingHeld = false
				hand.remove_child(heldItem)
				get_tree().root.get_child(1).add_child(heldItem)
				#maybe move this somewhere else once things work! :)
				sunCount -= heldItem.sunCost
			else:
				heldItem.queue_free()

func hasSeed():
	if hand.get_child_count() > 0:
		holdingSeed = true
	else:
		holdingSeed = false

func gainSun(amtSun:int):
	sunCount += amtSun
