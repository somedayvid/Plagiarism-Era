extends Node2D

@export var scene: PackedScene
var overlap := false
var packetRect : Rect2
@onready var border = $PacketBorder
@onready var plant_sprite = $PlantSprite

var costToPlant : int

func _ready():
	packetRect = Rect2(global_position.x, global_position.y,96,96)
	if scene != null:
		var instance = scene.instantiate()
		instance.staticImage = true
		instance.position = Vector2.ZERO
		instance.scale.x = 1
		instance.scale.y = 1
		add_child(instance)
	
		costToPlant = instance.sunCost
func _process(delta) -> void:
	if scene != null:
		if Singleton.mouseDown && packetRect.has_point(Singleton.mousePos) && !Singleton.holdingSeed:
			var instance = scene.instantiate()
			instance.global_position = get_tree().root.get_child(1).get_node("CursorTemp").global_position
			get_parent().get_parent().get_parent().get_node("Hand").add_child(instance)
			Singleton.holdingSeed = true
