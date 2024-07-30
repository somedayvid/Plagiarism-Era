extends Node2D

var damage

func _ready():
	damage = Attack.new(get_parent().damage)

func _on_body_entered(body):
	var hpCom = body.get_node("HealthComponent")
	if hpCom == null:
		pass
	elif hpCom.has_method("takeDamage"):
		hpCom.takeDamage(damage)
		get_parent().queue_free()
