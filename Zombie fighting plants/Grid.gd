extends Node2D

const GROUND_TILE = preload("res://ground_tile.tscn")
var placementGrid = []
@onready var tile_container = $"../TileContainer"
@onready var marker_2d = $"../Marker2D"

const matrixLength := 9
const matrixHeight := 5

const startX := 120
const startY := 155
const spriteSideLength := 100

var currentMouseGridPos := Vector2.ZERO
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
	var tileContainerList = tile_container.get_children()
	var currentIndex = 0
	for i in matrixLength:
		var tempArray = []
		for n in 5:
			tempArray.append(tileContainerList[currentIndex])
			currentIndex += 1
		placementGrid.append(tempArray)
	#for i in matrixHeight:
		#var tempArray = []
		#placementGrid.append(tempArray)
		#for n in matrixLength:
			#var groundTileInstance = GROUND_TILE.instantiate()
			#groundTileInstance.global_position = Vector2(n * 32, i * 32)
			#tile_container.add_child(groundTileInstance)
			#placementGrid[i].append(groundTileInstance)

	#var count = -1
	#for i in placementGrid:
		#count += 1
		#print(placementGrid[count])
		#
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
