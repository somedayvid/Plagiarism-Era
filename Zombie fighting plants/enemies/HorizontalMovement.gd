extends CharacterBody2D

@export var moveSpeed : float
@export var rightDir := false
var eating := false:
	get:
		return eating
	set(value):
		eating = value
var released := false
var type = "Zombie"

func _ready():
	if rightDir:
		velocity = Vector2(moveSpeed,0)
	else:
		velocity = Vector2(-moveSpeed,0)

func _physics_process(delta):
	if !eating:
		move_and_slide()

func _on_release_timer_timeout():
	released = true
