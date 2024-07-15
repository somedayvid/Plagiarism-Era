extends Node2D
@onready var text_edit = $TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	text_edit.text = str(Singleton.sunCount)

func _process(delta):
	text_edit.text = str(Singleton.sunCount)
