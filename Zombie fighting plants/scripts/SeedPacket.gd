extends Node2D

@export var scene: PackedScene
var overlap := false
var packetRect : Rect2
@onready var border = $PacketBorder
@onready var plant_sprite = $PlantSprite

var costToPlant : int

func _ready():
	packetRect = Rect2(global_position.x, global_position.y,96,96)
	var instance = scene.instantiate()
	instance.staticImage = true
	instance.position = global_position/40
	instance.scale.x = 1
	instance.scale.y = 1
	add_child(instance)
	
	costToPlant = instance.sunCost
	print(costToPlant)
func _process(delta) -> void:	
	if Singleton.mouseDown && packetRect.has_point(Singleton.mousePos) && !Singleton.holdingSeed:
		var instance = scene.instantiate()
		instance.global_position = get_viewport().get_mouse_position()
		get_parent().get_parent().get_node("Hand").add_child(instance)
		Singleton.holdingSeed = true
