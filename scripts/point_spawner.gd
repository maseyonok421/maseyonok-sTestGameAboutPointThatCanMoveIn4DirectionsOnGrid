extends Node2D

var curNumberOfPoints = 0
var listOfPoints = []
var pointScene = preload("res://prefabs//point.tscn")


func changeWaitTime():
	$Timer.wait_time -= 0.225
	$Timer.wait_time = max(0.1, $Timer.wait_time)

func _ready() -> void:
	get_parent().changeRespawnTime.connect(changeWaitTime)
	print("Point Spawner Inicialization: OK")


func _on_timer_timeout() -> void:
	
	if ( curNumberOfPoints >= Global.maxPointsOnScreen ):
		return
	
	var pointInstance = pointScene.instantiate()
	
	var curX
	var curY
	while true:
		curX = randi() \
			% (Global.gridSize*2+1) - Global.gridSize
		curY = randi() \
			% (Global.gridSize*2+1) - Global.gridSize
		
		if ( !listOfPoints.has(Vector2(curX, curY)) ):
			break
	
	pointInstance.positionX = curX
	pointInstance.positionY = curY
	add_child(pointInstance)
	pointInstance.pointDestroyed.connect(_on_point_destroyed)
	
	curNumberOfPoints += 1

func _on_point_destroyed(pointPos) -> void:
	listOfPoints.erase(pointPos)
	curNumberOfPoints -= 1
