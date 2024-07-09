extends Node2D

const GROUND_TILE = preload("res://ground_tile.tscn")
var placementGrid = []

const matrixLength := 9
const matrixHeight := 5

func _ready() -> void:
	for i in matrixHeight:
		var tempArray = []
		placementGrid.append(tempArray)
		for n in matrixLength:
			placementGrid[i].append(1)
	print(placementGrid)
