extends Node2D
@export var waveCounterDisplay := RichTextLabel

@export var basicZombie : PackedScene
@export var coneZombie : PackedScene

var difficulty := 1:
	set(value):
		clamp(difficulty, 1, 100)
var zombiesLeftToSpawn : int
var zombies = []

@onready var zombieTimer = $TimeBetweenZombieSpawns

@onready var zombieList = $ZombieList

func _ready():
	spawnWave()

func _process(delta):
	pass

func spawnWave():
	zombieTimer.start()

func spawnInRow(zombieToSpawn: PackedScene):
	var zombieInstance = zombieToSpawn.instantiate()
	zombieInstance.global_position = Vector2(1200, Singleton.spriteSideLength * rowToSpawnIn() + Singleton.startY + Singleton.spriteSideLength/2)
	zombieList.add_child.call_deferred(zombieInstance)

func rowToSpawnIn():
	return randi() % 5

func _on_time_between_zombie_spawns_timeout():
	spawnInRow(basicZombie)
	zombiesLeftToSpawn -= 1

func decrementTimer():
	zombieTimer.wait_time -= .1
