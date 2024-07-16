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

signal startAction

func _process(delta) -> void:
	if !staticImage:
		if beingHeld:
			global_position = Singleton.mousePos
		else:
			if !canAction: 
				startAction.emit()
				canAction = true
