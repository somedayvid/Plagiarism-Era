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
var lawnGrid : Node2D
var planterGrid : Node2D
var camera : Camera2D

var currentGrid : Node2D

var cameraLawnFocus := true

#gameStuff
var sunCount := 50

const thirstAffliction = preload("res://components/Afflictions/thirsty.tscn")
const lackSunAffliction = preload("res://components/Afflictions/sun_lacking.tscn")
const lackNutrientAffliction = preload("res://components/Afflictions/nutrient_lacking.tscn")
const lackSprayAffliction = preload("res://components/Afflictions/spray_lacking.tscn")

#grid stuff for other classes
var matrixLength := 9
const matrixHeight := 5

const startX := 128 
const startY := 168
const spriteSideLength := 96

func _ready():
	hand = get_tree().root.get_child(1).get_node("Hand")
	lawnGrid = get_tree().root.get_child(1).get_node("LawnScene").get_node("Grid")
	planterGrid = get_tree().root.get_child(1).get_node("GreenhouseScene").get_node("PlanterGrid")
	camera = get_tree().root.get_child(1).get_node("Camera2D")
	currentGrid = lawnGrid

func _process(delta):
	mouseStuff()

func mouseStuff():
	hasSeed()
	mousePress()
	cameraMoving()
	mousePosUpdates()

func mousePosUpdates():
	gridPos = currentGrid.currentMouseGridPos
	mousePos = get_viewport().get_mouse_position()
	if !cameraLawnFocus:
		mousePos.x -= 576.0 * 1.5

func cameraMoving():
	if Input.is_action_just_pressed("left"):
		camera.global_position = Vector2(-288, 0)
		cameraLawnFocus = false
		currentGrid = planterGrid
	if Input.is_action_just_pressed("right"):
		camera.global_position = Vector2(576,0)
		cameraLawnFocus = true
		currentGrid = lawnGrid

func mousePress():
	if Input.is_action_pressed("mouseAction"):
		mouseDown = true
	if Input.is_action_just_released("mouseAction"):
		mouseDown = false
		if holdingSeed:
			var heldItem = hand.get_child(0)
			if (currentGrid.currentMouseGridPos.x > -1 && currentGrid.currentMouseGridPos.y > -1 
			&& sunCount >= heldItem.sunCost && !currentGrid.placementGrid[gridPos.x][gridPos.y].hasPlant):
				heldItem.global_position = currentGrid.placementGrid[gridPos.x][gridPos.y].global_position
				currentGrid.placementGrid[gridPos.x][gridPos.y].hasPlant = true
				heldItem.gridPos = gridPos
				heldItem.beingHeld = false
				hand.remove_child(heldItem)
				currentGrid.get_child(1).add_child(heldItem)
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
