extends CharacterBody2D

@export var moveSpeed : float
var eating := false:
	get:
		return eating
	set(value):
		eating = value
var released := false
var type = "Zombie"
var damage := 10

func _ready():
	velocity = Vector2(-moveSpeed,0)

func _physics_process(delta):
	if !eating:
		move_and_slide()

func _on_release_timer_timeout():
	released = true
