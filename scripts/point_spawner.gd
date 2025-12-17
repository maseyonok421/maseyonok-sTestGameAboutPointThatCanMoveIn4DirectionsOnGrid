extends Node2D

var maxPointsOnScreen = 4
var curNumberOfPoints = 0
var pointScene = preload("res://prefabs//point.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Point Spawner Inicialization: OK")


func _on_timer_timeout() -> void:
	
	if ( curNumberOfPoints >= maxPointsOnScreen ):
		return
	
	var pointInstance = pointScene.instantiate()
	pointInstance.positionX = curNumberOfPoints
	pointInstance.positionY = curNumberOfPoints
	add_child(pointInstance)
	pointInstance.pointDestroyed.connect(_on_point_destroyed)
	
	curNumberOfPoints += 1

func _on_point_destroyed() -> void:
	curNumberOfPoints -= 1
