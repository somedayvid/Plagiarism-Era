extends Node2D

@export var sunScene : PackedScene
@export var fertilizerScene : PackedScene

var maxCompostAmt := 100
var currentCompostAmt := 0

func addCompost(sunValue: int):
	currentCompostAmt += sunValue
	if currentCompostAmt >= maxCompostAmt:
		fullyComposted()

func fullyComposted():
	currentCompostAmt = currentCompostAmt - maxCompostAmt
