extends Node2D
@export var waveCounterDisplay := RichTextLabel

@export var basicZombie : PackedScene
@onready var zombie = $"../Zombie"

var basicsToSpawn : int
var currentWave := 0
var zombiesToSpawn = []	

func _ready():
	currentWave += 1 
	basicsToSpawn = 2
	spawnWave()

func _process(delta):
	pass

func spawnWave():
	for zombie in basicsToSpawn:
		spawnInRow(basicZombie)

func spawnInRow(zombieToSpawn: PackedScene):
	var zombieInstance = zombieToSpawn.instantiate()
	zombieInstance.global_position = Vector2(1200, Singleton.spriteSideLength * rowToSpawnIn() + Singleton.startY)
	get_parent().add_child.call_deferred(zombieInstance)

func rowToSpawnIn():
	return randi() % 5
