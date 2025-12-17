extends Node2D

var pointScene = preload("res://prefabs//point.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Point Spawner Inicialization: OK")


func _on_timer_timeout() -> void:
	
	var pointInstance = pointScene.instantiate()
	pointInstance.positionX = 0
	pointInstance.positionY = 0
	
	add_child(pointInstance)
