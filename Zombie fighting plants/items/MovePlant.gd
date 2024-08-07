extends Node2D

func _process(delta):
	if (get_parent().beingHeld 
	&& Singleton.currentGrid.placementGrid[Singleton.gridPos.x][Singleton.gridPos.y].hasPlant 
	&& Singleton.mouseDown):
		self.get_parent().reparent(get_tree().root.get_child(1).get_node("LawnScene").get_node("UsableItems"))
		self.get_parent().beingHeld = false
		for i in Singleton.currentGrid.plantedList.size():
			if Singleton.currentGrid.plantedList[i].gridPos == Singleton.gridPos:
				Singleton.currentGrid.placementGrid[Singleton.gridPos.x][Singleton.gridPos.y].hasPlant = false
				Singleton.currentGrid.plantedList[i].beingHeld = true
				Singleton.currentGrid.plantedList[i].reparent(get_tree().root.get_child(1).get_node("Hand"))
  
