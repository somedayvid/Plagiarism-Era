extends Node2D

const GROUND_TILE = preload("res://ground_tile.tscn")
var placementGrid = []
@onready var tile_container = $"../TileContainer"

const matrixLength := 9
const matrixHeight := 5

#func _ready() -> void:
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
