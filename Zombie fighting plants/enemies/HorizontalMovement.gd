extends CharacterBody2D

@export var moveSpeed : float
@export var rightDir := false

func _ready():
	if rightDir:
		velocity = Vector2(moveSpeed,0)
	else:
		velocity = Vector2(-moveSpeed,0)

func _physics_process(delta):
	move_and_slide()
