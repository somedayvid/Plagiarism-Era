extends Node2D

@export var damageOnHit := 10.0
@export var timeBetweenAttack := 0.0
var damage
@onready var attackTimer = $TimeBetweenAttacks
var eatingTarget 

func _ready():
	damage = Attack.new()
	damage.damageOnHit = damageOnHit
	attackTimer.wait_time = timeBetweenAttack

func _process(delta):
	if eatingTarget == null:
		get_parent().eating = false
		attackTimer.stop()

func dealDamage():
	if eatingTarget != null:
		var hpCom = eatingTarget.get_node("HealthComponent")
		if hpCom == null:
			pass
		elif hpCom.has_method("_take_damage"):
			hpCom._take_damage(damage)

func _on_time_between_attacks_timeout():
	dealDamage()

func _on_plant_detection_area_entered(area):
	eatingTarget = area
	get_parent().eating = true
	attackTimer.start()
