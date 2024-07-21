extends Node2D

var placementGrid = []:
	get:
		return placementGrid
var tile_container

@export var matrixLength := 9
@export var matrixHeight := 5
@export var startX := 128
@export var startY := 168
var spriteSideLength := 96

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

func _ready() -> void:
	#collects tiles in gamescene for the grid
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
	updateMousePos()
	gridCheck()

##checks if mouse is on grid and updates tiles to highlight when hovered
func gridCheck():
		#checks if the mouse grid pos is within the grid 
	if ((currentMouseGridPos.x >= 0 && currentMouseGridPos.x <= matrixLength - 1) 
	&& (currentMouseGridPos.y >= 0 && currentMouseGridPos.y <= matrixHeight - 1)):
		#if so then highlights all tiles the mouse hovers over and dehighlights any that are no longer hovered over
		if placementGrid[currentMouseGridPos.x][currentMouseGridPos.y].lit != true:
			placementGrid[currentMouseGridPos.x][currentMouseGridPos.y].highlight()
		if previousMouseGridPos != currentMouseGridPos:
			placementGrid[previousMouseGridPos.x][previousMouseGridPos.y].dehighlight()
	else: #dehighlights once mouse is off grid
		placementGrid[previousMouseGridPos.x][previousMouseGridPos.y].dehighlight() 
	previousMouseGridPos = currentMouseGridPos

##responsible for updating mouse's position on the grid 
func updateMousePos():
	gridX = (Singleton.mousePos.x - startX)/spriteSideLength
	gridY = (Singleton.mousePos.y - startY)/spriteSideLength
	currentMouseGridPos = Vector2(floor(gridX), floor(gridY))
