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

#0 for greenhouse, 1 for lawn
var currentPlace = 0

var actionDelay := 1.0:
	get:
		return actionDelay

var currentGrowthStage := 0:
	set(value):
		clamp(maxGrowthStage, 0, 4)
var maxGrowthStage := 4

var happinessToGrow : int
var currentHappiness := 25:
	set(value):
		clamp(currentHappiness, 0, 100)

@onready var waterTimer = $TimerContainer/NeedsWater
@onready var fertilizerTimer = $TimerContainer/NeedsFertilizer
@onready var sunTimer = $TimerContainer/NeedsSun
@onready var sprayTimer = $TimerContainer/NeedsSpray
@onready var happyRateTimer = $TimerContainer/NormalHappinessGrowth

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
				happyRateTimer.start()

func _on_needs_water_timeout():
	var instance = Singleton.thirstAffliction.instantiate()
	instance.position = Vector2(-10, -10)
	afflictions.add_child(instance)

func _on_needs_fertilizer_timeout():
	var instance = Singleton.lackNutrientAffliction.instantiate()
	instance.position = Vector2(0, -10)
	afflictions.add_child(instance)

func _on_needs_sun_timeout():
	var instance = Singleton.lackSunAffliction.instantiate()
	instance.position = Vector2(10, -10)
	afflictions.add_child(instance)

func _on_needs_spray_timeout():
	var instance = Singleton.lackSprayAffliction.instantiate()
	instance.position = Vector2(20, -10)
	afflictions.add_child(instance)

func _on_afflictions_child_entered_tree(node):
	var name = node.get_name()
	match(name):
		"Thirsty":
			thirsty = true
			actionDelay += .2
			waterTimer.stop()
		"NutrientLacking":
			actionDelay += .2
		"SunLacking":
			actionDelay += .2
		"SprayLacking":
			actionDelay += .2

func _on_afflictions_child_exiting_tree(node):
	var name = node.get_name()
	match(name):
		"Thirsty":
			thirsty = false
			actionDelay -= .2
			waterTimer.start()
		"NutrientLacking":
			actionDelay -= .2
		"SunLacking":
			actionDelay -= .2
		"SprayLacking":
			actionDelay -= .2

func removeAffliction():
	if afflictions.get_child_count() != 0:
		var affliction = afflictions.get_node("Thirsty")
		affliction.queue_free()

func advanceGrowthStage():
	currentGrowthStage += 1
	currentHappiness = 25

func _on_normal_happiness_growth_timeout():
	currentHappiness += 1
