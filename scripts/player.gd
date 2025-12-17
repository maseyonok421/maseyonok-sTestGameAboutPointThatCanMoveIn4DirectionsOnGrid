extends Node2D

var positionX = 0
var positionY = 0
var time = 0
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	
	position.x = positionX * ( Global.cellSize + Global.gridLineSize)
	position.y = positionY * ( Global.cellSize + Global.gridLineSize)
	
	time += (delta*25)
	if (int)(time)%10 == 7 :
		print("X = ", positionX, "; Y = ", positionY, "\n")
