extends Node

#mouseStuff
var mousePos := Vector2.ZERO
var holdingItem := false:
	set(value):
		holdingItem = value
	get:
		return holdingItem
var gridPos := Vector2.ZERO
var mouseDown := false
var justPressed := false
var hand : Node2D
var lawnGrid : Node2D
var planterGrid : Node2D
var camera : Camera2D
var compostBin : Node2D

var currentGrid : Node2D
var weatherCycle : Node2D
var cameraLawnFocus := true

var cursorHover

#gameStuff
var sunCount := 100

#grid stuff for other classes
var matrixLength := 9
const matrixHeight := 5

const startX := 128 
const startY := 168
const spriteSideLength := 96

const lackNutrientAffliction = preload("res://components/Afflictions/nutrient_lacking.tscn")
const lackSprayAffliction = preload("res://components/Afflictions/spray_lacking.tscn")
const lackSunAffliction = preload("res://components/Afflictions/sun_lacking.tscn")
const thirstAffliction = preload("res://components/Afflictions/thirsty.tscn")

func _ready():
	hand = get_tree().root.get_child(1).get_node("Hand")
	lawnGrid = get_tree().root.get_child(1).get_node("LawnScene").get_node("Grid")
	planterGrid = get_tree().root.get_child(1).get_node("GreenhouseScene").get_node("PlanterGrid")
	camera = get_tree().root.get_child(1).get_node("Camera2D")
	compostBin = get_tree().root.get_child(1).get_node("CompostBin")
	cursorHover = get_tree().root.get_child(1).get_node("CursorTemp").item
	
	currentGrid = lawnGrid

func _process(delta):
	mouseStuff()

func mouseStuff():
	mousePress()
	cameraMoving()
	mousePosUpdates()

func mousePosUpdates():
	gridPos = currentGrid.currentMouseGridPos
	mousePos = get_viewport().get_mouse_position()
	if !cameraLawnFocus:
		mousePos.x -= 576.0 * 1.75

func cameraMoving():
	if Input.is_action_just_pressed("left"):
		camera.global_position = Vector2(-448, 0)
		cameraLawnFocus = false
		currentGrid = planterGrid
	if Input.is_action_just_pressed("right"):
		camera.global_position = Vector2(576,0)
		cameraLawnFocus = true
		currentGrid = lawnGrid

func mousePress():
	if Input.is_action_pressed("mainAction"):
		mouseDown = true
	hasSeed();
	if holdingItem:
		var heldItem = hand.get_child(0)
		if heldItem.type == "Plant":
			var sunToCost := 0
			if heldItem.newPlant == true:
				sunToCost = heldItem.sunCost
			else: 
				sunToCost = 25
			if Input.is_action_just_pressed("drop"):
				if heldItem.gridPos != Vector2.ZERO:
					returnToLastPlantPos(heldItem, planterGrid)
					print(1)
				else:
					deleteFromScene(heldItem)
			if Input.is_action_just_pressed("mainAction"):
				if (currentGrid.currentMouseGridPos.x > -1 && currentGrid.currentMouseGridPos.y > -1 
				&& hasEnoughSun(sunToCost) && !currentGrid.placementGrid[gridPos.x][gridPos.y].hasPlant):
					if currentGrid == lawnGrid && !heldItem.lawnReady:
						if !heldItem.newPlant:
							returnToLastPlantPos(heldItem, planterGrid)
							print(2)
						else:
							deleteFromScene(heldItem)
					else:
						heldItem.global_position = currentGrid.placementGrid[gridPos.x][gridPos.y].global_position
						currentGrid.placementGrid[gridPos.x][gridPos.y].hasPlant = true
						heldItem.newPlant = false
						heldItem.gridPos = gridPos
						heldItem.beingHeld = false
						hand.remove_child(heldItem)
						currentGrid.get_child(1).add_child(heldItem)
						#maybe move this somewhere else once things work! :)
						sunCount -= sunToCost
				else:
					if !heldItem.newPlant:
						pass
					else: deleteFromScene(heldItem)
		elif heldItem.type == "Item":
			if Input.is_action_pressed("drop"):
				heldItem.beingHeld = false
	if Input.is_action_just_released("mainAction"):
		mouseDown = false

func hasSeed():
	if hand.get_child_count() > 0:
		holdingItem = true
	else:
		holdingItem = false
		
func gainSun(amtSun:int):
	sunCount += amtSun
	
func deleteFromScene(scene: Node):
	scene.queue_free()
	
func addCompost(sunValue: int):
	compostBin.addCompost(sunValue)
	
func returnToLastPlantPos(heldItem, grid):
	heldItem.global_position = grid.placementGrid[heldItem.gridPos.x][heldItem.gridPos.y].global_position
	heldItem.beingHeld = false
	hand.remove_child(heldItem)
	grid.get_child(1).add_child(heldItem)
	grid.placementGrid[heldItem.gridPos.x][heldItem.gridPos.y].hasPlant = true
	
func hasEnoughSun(sunExpense : int) -> bool:
	if sunCount >= sunExpense:
		return true
	else:
		return false
