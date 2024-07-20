extends Node2D

var placementGrid = []:
	get:
		return placementGrid
var tile_container

@export var matrixLength := 9
@export var matrixHeight := 5

@export var startX := 128
@export var startY := 168
@export var spriteSideLength := 96

var currentMouseGridPos := Vector2.ZERO:
	get:
		return currentMouseGridPos
var previousMouseGridPos := Vector2.ZERO

var gridX := 0.0:
	set(value):
		if value >= matrixLength:
			gridX = -1.0
		elif value < 0.0:
			gridX = -1.0
		else:
			gridX = value 
var gridY := 0.0:
	set(value):
		if value >= matrixHeight:
			gridY = -1.0
		elif value < 0.0:
			gridY = -1.0
		else:
			gridY = value 
var onGrid := false:
	get:
		return onGrid

func _ready() -> void:
	tile_container = get_child(0)
	var tileContainerList = tile_container.get_children()
	var currentIndex = 0
	for i in matrixLength:
		var tempArray = []
		for n in matrixHeight:
			tempArray.append(tileContainerList[currentIndex])
			currentIndex += 1
		placementGrid.append(tempArray)

func _process(delta) -> void:
	_change_mouse_pos()

	if ((currentMouseGridPos.x >= 0 && currentMouseGridPos.x <= matrixLength - 1) 
	&& (previousMouseGridPos.y >= 0 && previousMouseGridPos.y <= matrixHeight - 1)):
		onGrid = true
		if placementGrid[currentMouseGridPos.x][previousMouseGridPos.y].lit != true:
			placementGrid[currentMouseGridPos.x][previousMouseGridPos.y].lit = true
			placementGrid[currentMouseGridPos.x][previousMouseGridPos.y]._highlight()
		if previousMouseGridPos != currentMouseGridPos:
			placementGrid[previousMouseGridPos.x][previousMouseGridPos.y].lit = false
			placementGrid[previousMouseGridPos.x][previousMouseGridPos.y]._dehighlight()
	else:
		onGrid = false
	
	previousMouseGridPos = currentMouseGridPos
	
func _change_mouse_pos():
	gridX = (Singleton.mousePos.x - startX)/spriteSideLength
	gridY = (Singleton.mousePos.y - startY)/spriteSideLength
	currentMouseGridPos = Vector2(floor(gridX), floor(gridY))
