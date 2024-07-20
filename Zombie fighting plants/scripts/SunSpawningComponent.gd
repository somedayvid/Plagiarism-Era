extends Node2D

@onready var time_between_sun_spawn = $"../TimeBetweenSunSpawn"
@export var scene : PackedScene
@onready var marker_2d = $"../Marker2D"

func _on_plant_parent_start_action():
	time_between_sun_spawn.start()

func _on_time_between_sun_spawn_timeout():
	spawnSun()

func spawnSun():
	var instance = scene.instantiate()
	instance.global_position = marker_2d.global_position
	instance.plantSpawned = true
	get_parent().get_parent().add_child(instance)
	
