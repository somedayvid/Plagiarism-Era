extends Node2D

@export var scene: PackedScene
@onready var plant_sprite = $PlantSprite

var costToPlant : int
var hovered := false

func _ready():
	if scene != null:
	
		var instance = scene.instantiate()
		instance.staticImage = true
		instance.position = Vector2.ZERO
		add_child(instance)
	
		costToPlant = instance.sunCost

func _process(delta) -> void:
	if scene != null:
		if Singleton.mouseDown && hovered && !Singleton.holdingItem:
			var instance = scene.instantiate()
			instance.global_position = get_tree().root.get_child(1).get_node("CursorTemp").global_position
			get_parent().get_parent().get_parent().get_node("Hand").add_child(instance)
			Singleton.holdingItem = true

func _on_area_2d_area_entered(area):
	hovered = true

func _on_area_2d_area_exited(area):
	hovered = false
