extends Node2D

@export var maxHealth := 40.0
var currentHealth

func _ready() -> void:
	currentHealth = maxHealth
	
func takeDamage(damageToTake: Attack):
	currentHealth -= damageToTake.damageOnHit
	die()
	
func die():
	if currentHealth <= 0:
		get_parent().queue_free()
