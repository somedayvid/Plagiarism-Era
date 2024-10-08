extends Node2D

@export var damageOnHit := 100.0
@export var timeBetweenAttack := 1.0
var damage
@onready var attackTimer = $TimeBetweenAttacks
var eatingTarget 

func _ready():
	damage = Attack.new(get_parent().damage)
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
		elif hpCom.has_method("takeDamage"):
			hpCom.takeDamage(damage)

func _on_time_between_attacks_timeout():
	dealDamage()

func _on_plant_detection_area_entered(area):
	if area.has_method("returnType"):
		if area.returnType() == "Plant":
			if !area.beingHeld:
				eatingTarget = area
				get_parent().eating = true
				attackTimer.start()

func _on_plant_detection_area_exited(area):
	eatingTarget = null
