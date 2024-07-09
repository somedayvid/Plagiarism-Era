extends Node2D

@export var damageOnHit := 10.0
var damage

func _ready():
	damage = Attack.new()
	damage.damageOnHit = damageOnHit

func _on_body_entered(body):
	var hpCom = body.get_node("HealthComponent")
	if hpCom == null:
		pass
	elif hpCom.has_method("_take_damage"):
		hpCom._take_damage(damage)
		get_parent().queue_free()
