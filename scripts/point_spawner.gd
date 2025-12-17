extends Node2D

var maxPointsOnScreen = 4
var curNumberOfPoints = 0
var listOfPoints = []
var pointScene = preload("res://prefabs//point.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Point Spawner Inicialization: OK")


func _on_timer_timeout() -> void:
	
	if ( curNumberOfPoints >= maxPointsOnScreen ):
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
