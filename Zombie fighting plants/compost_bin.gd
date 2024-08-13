extends Node2D

@export var sunScene : PackedScene
@export var fertilizerScene : PackedScene

var maxCompostAmt := 100
var currentCompostAmt := 0
var plantHover := false

@onready var sprite = $Sprite2D

func addCompost(sunValue: int):
	currentCompostAmt += sunValue
	if currentCompostAmt >= maxCompostAmt:
		fullyComposted()
	compostAmtChanged()

func fullyComposted():
	currentCompostAmt = currentCompostAmt - maxCompostAmt
	compostAmtChanged()

func _on_area_2d_area_entered(area):
	plantHover = true

func _on_area_2d_area_exited(area):
	plantHover = false

func compostAmtChanged():
	sprite.self_modulate = Color8(255 * currentCompostAmt/maxCompostAmt,255 * currentCompostAmt/maxCompostAmt,255 * currentCompostAmt/maxCompostAmt)
	print(sprite.self_modulate)
