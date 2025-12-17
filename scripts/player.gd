extends Node2D

@export var positionX = 0
@export var positionY = 0
var time = 0

func moveToCoordinates() -> void:
	global_position.x = \
	positionX * ( Global.cellSize + Global.gridLineSize)
	global_position.y = \
	positionY * ( Global.cellSize + Global.gridLineSize)


func _ready() -> void:
	
	moveToCoordinates()
	
	$Area2D/CollisionShape2D.scale = Vector2(
		Global.cellSize/2, Global.cellSize/2
	)
	
	print("Player inicizlization: OK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if   Input.is_action_just_pressed("ui_left"):
		positionX -= 1
	elif Input.is_action_just_pressed("ui_right"):
		positionX += 1
	elif Input.is_action_just_pressed("ui_up"):
		positionY -= 1
	elif Input.is_action_just_pressed("ui_down"):
		positionY += 1
	
	moveToCoordinates()
	
	time += (delta*250)
	if (int)(time)%100 == 7 :
		print("X = ", positionX, "; Y = ", positionY, 
		"; score = ", Global.score, "\n")
