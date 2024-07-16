extends Node2D

@export var maxHealth := 40.0
var currentHealth

func _ready() -> void:
	currentHealth = maxHealth
	
func _take_damage(damageToTake: Attack):
	currentHealth -= damageToTake.damageOnHit
	print(currentHealth)
	_die()
	
func _die():
	if currentHealth <= 0:
		get_parent().queue_free()
