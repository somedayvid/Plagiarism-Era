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
var currentGrid = 0
var lawnReady := true

var actionDelay := 1.0:
	get:
		return actionDelay

var currentGrowthStage := 0
var maxGrowthStage := 4
var canGrow := true

var happinessToGrow := 100
var currentHappiness := 25
var currentHappinessGain := 2

var newPlant := true

@onready var waterTimer = $TimerContainer/NeedsWater
@onready var fertilizerTimer = $TimerContainer/NeedsFertilizer
@onready var sprayTimer = $TimerContainer/NeedsSpray
@onready var happyRateTimer = $TimerContainer/NormalHappinessGrowth

@export var waterTiming : float
@export var fertilizerTiming : float
@export var sprayTiming : float

var afflictionTimingsList = []

@onready var afflictions = $Afflictions

#0: water, 1: spray, 2: fertilizer
var currentAfflictionDict = {0:false, 1:false, 2:false}

signal startAction
signal upgrade

func _ready():
	if !staticImage:
		waterTimer.wait_time = waterTiming
		fertilizerTimer.wait_time = fertilizerTiming
		sprayTimer.wait_time = sprayTiming
		
		waterTimer.start()
		fertilizerTimer.start()
		sprayTimer.start()

func _process(delta) -> void:
	if !staticImage:
		if beingHeld:
			global_position = Singleton.mousePos
		else:
			if !canAction: 
				startAction.emit()
				canAction = true
				happyRateTimer.start()
	if canAction && canGrow:
		if currentHappiness >= happinessToGrow:
			advanceGrowthStage()
	if currentHappiness <= 0:
		die()
	if !lawnReady && currentGrowthStage >= 2:
		lawnReady = true

func _on_needs_water_timeout():
	var instance = Singleton.thirstAffliction.instantiate()
	instance.position = Vector2(-10, -10)
	afflictions.add_child(instance)

func _on_needs_fertilizer_timeout():
	var instance = Singleton.lackNutrientAffliction.instantiate()
	instance.position = Vector2(0, -10)
	afflictions.add_child(instance)

func _on_needs_spray_timeout():
	var instance = Singleton.lackSprayAffliction.instantiate()
	instance.position = Vector2(20, -10)
	afflictions.add_child(instance)

#0: water, 1: spray, 2: fertilizer
func _on_afflictions_child_entered_tree(node):
	var name = node.get_name()
	match(name):
		"Thirsty":
			currentAfflictionDict[0] = true
			waterTimer.stop()
		"NutrientLacking":
			currentAfflictionDict[2] = true
			fertilizerTimer.stop()
		"SprayLacking":
			currentAfflictionDict[1] = true
			sprayTimer.stop()
	actionDelay += .2
	currentHappinessGain -= 1

func _on_afflictions_child_exiting_tree(node):
	var name = node.get_name()
	match(name):
		"Thirsty":
			currentAfflictionDict[0] = true
			waterTimer.start()
		"NutrientLacking":
			currentAfflictionDict[0] = true
			fertilizerTimer.start()
		"SprayLacking":
			currentAfflictionDict[0] = true
			sprayTimer.start()
	actionDelay -= .2
	currentHappinessGain += 1

func removeAffliction(toRemove : String):
	var affliction = afflictions.get_node(toRemove)
	affliction.queue_free()

func advanceGrowthStage():
	if currentGrowthStage < maxGrowthStage:
		currentGrowthStage += 1
		currentHappiness = 25
		animation.scale += Vector2(.5,.5)
		upgrade.emit()
	else:
		canGrow = false

func _on_normal_happiness_growth_timeout():
	currentHappiness += currentHappinessGain
func die():
	canAction = false
	animation.self_modulate = Color8(20,40,80)

#0: water, 1: spray, 2: fertilizer
func _on_area_entered(area):
	match(area.get_parent().name):
		"WateringCan":
			if afflictions.has_node("Thirsty"):
				removeAffliction("Thirsty")
		"Spray":
			if afflictions.has_node("SprayLacking"):
				removeAffliction("SprayLacking")
		"Fertilizer":
			if afflictions.has_node("NutrientLacking"):
				removeAffliction("NutrientLacking")
		_:
			pass

func returnType():
	return type

func deleteFromScene():
	queue_free()
