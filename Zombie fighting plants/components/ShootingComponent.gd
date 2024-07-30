extends Node2D

@export var scene: PackedScene

@onready var bullet_point = $"../BulletPoint"
@onready var zombieRay = $"../ZombieDetection"

@onready var in_between_shots = $"../InBetweenShots"
@onready var burst_timer = $"../BurstTimer"

var attackDamage := 20
var attackSpeed : float
var additionalShots := 0
var timeBetweenBurstShots := .1

var tempBurst
signal stopAction

func _ready():
	attackSpeed = in_between_shots.wait_time
	burst_timer.wait_time = timeBetweenBurstShots

func _process(delta):
	if get_parent().canAction && !zombieRay.is_colliding() && !in_between_shots.is_stopped():
		in_between_shots.stop()
	elif get_parent().canAction && zombieRay.is_colliding() && in_between_shots.is_stopped():
		in_between_shots.start()
	
func _on_in_between_shots_timeout():
	shoot()
	tempBurst = additionalShots
	burst_timer.start()

func shoot():
	var bulletInstance = scene.instantiate()
	bulletInstance.damage = attackDamage
	bulletInstance.global_position = bullet_point.global_position
	get_parent().get_parent().add_child(bulletInstance)

func consumeBurstShot():
	if tempBurst > 0:
		tempBurst -= 1
		shoot()
		if tempBurst > 0:
			burst_timer.start()

func _on_pea_shooter_start_action():
	in_between_shots.start() 

func _on_pea_shooter_upgrade():
	additionalShots += 1

func _on_burst_timer_timeout():
	consumeBurstShot()
