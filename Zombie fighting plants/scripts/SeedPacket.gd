extends Node2D

@export var scenes: PackedScene
var overlap := false

func _process(delta) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && overlap && !Singleton.holdingSeed:
		var instance = scenes.instantiate()
		instance.global_position = get_viewport().get_mouse_position()
		get_parent().add_child(instance)
		Singleton.holdingSeed = true

func _on_area_2d_area_entered(area):
	overlap = true
func _on_area_2d_area_exited(area):
	overlap = false
