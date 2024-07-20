extends Node2D

@onready var bullet_point = $"../BulletPoint"
@onready var in_between_shots = $"../InBetweenShots"
@export var scene: PackedScene
@onready var zombieRay = $"../ZombieDetection"

signal stopAction

func _process(delta):
	if get_parent().canAction && !zombieRay.is_colliding() && !in_between_shots.is_stopped():
		in_between_shots.stop()
	elif get_parent().canAction && zombieRay.is_colliding() && in_between_shots.is_stopped():
		in_between_shots.start()
	
func _on_in_between_shots_timeout():
	_shoot()
	
func _shoot():
	var bulletInstance = scene.instantiate()
	bulletInstance.global_position = bullet_point.global_position
	get_parent().get_parent().add_child(bulletInstance)

func _on_pea_shooter_start_action():
	in_between_shots.start()
	

