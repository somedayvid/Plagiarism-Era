extends Area2D

var canAction := false:
	get:
		return canAction
var beingHeld := true:
	get:
		return beingHeld
	set(value):
		beingHeld = value
var staticImage := false:
	set(value):
		staticImage = value
@export var sunCost := 0:
	get:
		return sunCost
@export var actionNode : Node2D
var gridPos := Vector2.ZERO:
	set(value):
		gridPos = value
var type = "Plant"
@onready var animation = $Animation

var currentGrowthStage := 0
var maxGrowthStage := 4

@onready var waterTimer = $TimerContainer/NeedsWater
@onready var fertilizerTimer = $TimerContainer/NeedsFertilizer
@onready var sunTimer = $TimerContainer/NeedsSun
@onready var sprayTimer = $TimerContainer/NeedsSpray

@export var waterTiming := 1.0
@export var fertilizerTiming := 1.0
@export var sunTiming := 1.0
@export var sprayTiming := 1.0

var thirsty := false:
	get:
		return thirsty
	set(value):
		thirsty = value

@onready var afflictions = $Afflictions

signal startAction

func _ready():
	waterTimer.wait_time = waterTiming
	fertilizerTimer.wait_time = fertilizerTiming
	sunTimer.wait_time = sunTiming
	sprayTimer.wait_time = sprayTiming

func _process(delta) -> void:
	if !staticImage:
		if beingHeld:
			global_position = Singleton.mousePos
		else:
			if !canAction: 
				startAction.emit()
				canAction = true

func _on_needs_water_timeout():
	var instance = Singleton.thirstAffliction.instantiate()
	instance.global_position = Vector2.ZERO
	afflictions.add_child(instance)

func _on_needs_fertilizer_timeout():
	pass

func _on_needs_sun_timeout():
	pass

func _on_needs_spray_timeout():
	pass

func _on_afflictions_child_entered_tree(node):
	var name = node.get_name()
	match(name):
		"Thirsty":
			thirsty = true
		"NutrientLacking":
			pass
		"SunLacking":
			pass
		"SprayLacking":
			pass
