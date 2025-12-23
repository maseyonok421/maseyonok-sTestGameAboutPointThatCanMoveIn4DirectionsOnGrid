extends Node2D

@export var positionX = 0
@export var positionY = 0
var time = 0

var direction = -1 # -1 - off;    0 - left; 1 - up; 
#                     2 - right;  3 - down;

var isMovingX = 0
var isMovingY = 0

func moveToCoordinates() -> void:
	global_position.x = \
	positionX * ( Global.cellSize + Global.gridLineSize)
	global_position.y = \
	positionY * ( Global.cellSize + Global.gridLineSize)

func checkMovement() -> void:
	if   positionX >  Global.gridSize:
		positionX  =  Global.gridSize
	elif positionX < -Global.gridSize:
		positionX  = -Global.gridSize
	elif positionY >  Global.gridSize:
		positionY  =  Global.gridSize
	elif positionY < -Global.gridSize:
		positionY  = -Global.gridSize

func _ready() -> void:
	
	moveToCoordinates()
	
	$Area2D/CollisionShape2D.scale = Vector2(
		Global.cellSize/2, Global.cellSize/2
	)
	
	print("Player inicizlization: OK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$Camera/ScoreLabel.text = str(Global.score)
	$Camera/PositionInfoLabel.text = \
	"X = " + str(positionX) + "; Y = " + str(positionY)
	
	if   Input.is_action_just_released("ui_left")  \
	&& direction == 0:
		direction = -1
		$moveTimer.stop()
	elif Input.is_action_just_released("ui_up")  \
	&& direction == 1:
		direction = -1
		$moveTimer.stop()
	elif Input.is_action_just_released("ui_right")  \
	&& direction == 2:
		direction = -1
		$moveTimer.stop()
	elif Input.is_action_just_released("ui_down")  \
	&& direction == 3:
		direction = -1
		$moveTimer.stop()

	
	if   Input.is_action_just_pressed("ui_left"):
		positionX -= 1
		direction = 0
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_right"):
		positionX += 1
		direction = 2
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_up"):
		positionY -= 1
		direction = 1
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_down"):
		positionY += 1
		direction = 3
		$moveTimer.start()
	
	moveToCoordinates()
	checkMovement()
	
	time += (delta*250)
	if (int)(time)%100 == 7 :
		print("X = ", positionX, "; Y = ", positionY, 
		"; score = ", Global.score, "\n")


func _on_move_timer_timeout() -> void:
	if   direction == -1:
		pass
	elif direction == 0:
		positionX -= 1
	elif direction == 1:
		positionY -= 1
	elif direction == 2:
		positionX += 1
	elif direction == 3:
		positionY += 1
