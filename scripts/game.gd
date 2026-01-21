extends Node2D

signal redrawGrid()
signal changeRespawnTime()
signal showNewLevel()
signal showGameEnd()
signal showGameStart()

func _ready() -> void:
	#$bg.position += Vector2(
		#Global.fullCellSize/2 + Global.gridLineSize/2-0.5,
		#Global.fullCellSize/2 + Global.gridLineSize/2-0.5)
	emit_signal("showGameStart")
	pass


func _on_gameEnd_timer_timeout():
	get_tree().quit()

func _process(delta: float) -> void:
	if Global.score >= Global.xpForLevels:
		Global.curLevel += 1
		Global.xpForPrev = Global.xpForLevels
		Global.xpForLevels += \
		floor(Global.xpForLevels*Global.xpKoef)
		
		if Global.curLevel < 6:
			emit_signal("showNewLevel")
		else:
			emit_signal("showGameEnd")
			var timer = Timer.new()
			timer.wait_time = 5.0
			add_child(timer)
			timer.timeout.connect(_on_gameEnd_timer_timeout)
			timer.start()
		
		if Global.curLevel == 1 || Global.curLevel == 4 || \
		Global.curLevel == 5 || Global.curLevel == 6:
			Global.gridSize += 1
			emit_signal("redrawGrid")
		if Global.curLevel == 2 || Global.curLevel == 4 || \
		Global.curLevel == 5 || Global.curLevel == 6:
			Global.maxPointsOnScreen += 4
		if Global.curLevel == 2 || Global.curLevel == 3 || \
		Global.curLevel == 5 || Global.curLevel == 6:
			emit_signal("changeRespawnTime")
			
