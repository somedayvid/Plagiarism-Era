extends Node2D
const SUN = preload("res://ManagerScripts/sun.tscn")
@onready var text_edit = $TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	text_edit.text = str(Singleton.sunCount)

func _process(delta):
	text_edit.text = str(Singleton.sunCount)

func _on_sun_spawn_timeout():
	spawnSun()

func spawnSun():
	var spawnPos = Vector2(randi() % 1152,randi() % -150 - 50)
	var instance = SUN.instantiate()
	instance.global_position = spawnPos
	get_parent().add_child(instance)
