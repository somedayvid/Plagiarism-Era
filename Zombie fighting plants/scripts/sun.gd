extends CharacterBody2D

var fallSpeed := 100:
	set(value):
		fallSpeed = value
var landed := false
@onready var disappear_timer = $DisappearTimer
@onready var landedTimer = $LandedTimer
var type := "Sun":
	get:
		return type
var sunValue := 50:
	get:
		return sunValue
var plantSpawned := false:
	set(value):
		plantSpawned = value

func _ready():
	velocity = Vector2.DOWN * fallSpeed
	if plantSpawned:
		landedTimer.wait_time = .25
	else:
		landedTimer.wait_time = randi() % 4 + 2
	landedTimer.start()

func _process(delta):
	if landed:
		velocity = Vector2.ZERO
	move_and_slide()

func _on_landed_timeout():
	landed = true
	disappear_timer.start()

func _on_disappear_timer_timeout():
	queue_free()
