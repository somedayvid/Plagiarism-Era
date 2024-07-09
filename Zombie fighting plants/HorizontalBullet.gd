extends CharacterBody2D

@export var bulletSpeed : float

func _ready():
	velocity = Vector2(bulletSpeed, 0)

func _physics_process(delta):
	move_and_slide()
