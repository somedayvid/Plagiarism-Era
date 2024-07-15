extends Area2D

@onready var bullet_point = $BulletPoint
@onready var in_between_shots = $InBetweenShots
const PEA_BULLET = preload("res://plants/pea_bullet.tscn")
var canShoot := false
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

func _process(delta) -> void:
	if !staticImage:
		if beingHeld:
			global_position = Singleton.mousePos
		else:
			if !canShoot: 
				in_between_shots.start()
				canShoot = true 
func _on_in_between_shots_timeout():
	_shoot()
	
func _shoot():
	var bulletInstance = PEA_BULLET.instantiate()
	bulletInstance.global_position = bullet_point.global_position
	get_parent().add_child(bulletInstance)
