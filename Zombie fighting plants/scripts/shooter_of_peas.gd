extends Area2D

@onready var bullet_point = $BulletPoint
@onready var in_between_shots = $InBetweenShots
const PEA_BULLET = preload("res://pea_bullet.tscn")
var canShoot

func _ready():
	canShoot = false
	
func _on_in_between_shots_timeout():
	_shoot()
	
func _shoot():
	var bulletInstance = PEA_BULLET.instantiate()
	bulletInstance.global_position = bullet_point.global_position
	get_parent().add_child(bulletInstance)
