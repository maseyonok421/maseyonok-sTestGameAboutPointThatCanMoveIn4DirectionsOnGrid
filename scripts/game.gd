extends Node2D

signal redrawGrid()

func _ready() -> void:
	#$bg.position += Vector2(
		#Global.fullCellSize/2 + Global.gridLineSize/2-0.5,
		#Global.fullCellSize/2 + Global.gridLineSize/2-0.5)
	pass



func _process(delta: float) -> void:
	if Global.score >= Global.xpForLevels:
		Global.curLevel += 1
		Global.xpForLevels += \
		floor(Global.xpForLevels*Global.xpKoef)
		
		if Global.curLevel == 1:
			Global.gridSize += 1
		
		emit_signal("redrawGrid")
