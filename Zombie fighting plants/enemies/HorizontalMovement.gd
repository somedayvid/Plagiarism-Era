extends CharacterBody2D

@export var moveSpeed : float

func _ready():
	velocity = Vector2(-moveSpeed,0)

func _physics_process(delta):
	move_and_slide()
