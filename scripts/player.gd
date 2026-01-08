extends Node2D

signal getPlayerCoords(x: int, y: int)

var playerRemnantScene = preload("res://prefabs/player_remnant.tscn")

@export var positionX = 0
@export var positionY = 0
var time = 0

var direction = -1 # -1 - off;    0 - left; 1 - up; 
#                     2 - right;  3 - down;

var isMovingX = 0
var isMovingY = 0

var nX = 0
var nY = 0

func spawnRemnant( x, y ):
	var remnantInstance = playerRemnantScene.instantiate()
	remnantInstance.positionX = x
	remnantInstance.positionY = y
	add_child(remnantInstance)

func moveToCoordinates() -> void:
	if positionX != nX || positionY != nY:
		spawnRemnant(positionX, positionY)
		positionX = nX
		positionY = nY
	
	global_position.x = \
	positionX * ( Global.cellSize + Global.gridLineSize)
	global_position.y = \
	positionY * ( Global.cellSize + Global.gridLineSize)

func checkMovement() -> void:
	if   nX > Global.gridSize:
		nX = Global.gridSize
	elif nX < -Global.gridSize:
		nX  = -Global.gridSize
	elif nY >  Global.gridSize:
		nY  =  Global.gridSize
	elif nY < -Global.gridSize:
		nY  = -Global.gridSize

func _ready() -> void:
	
	moveToCoordinates()
	
	$Area2D/CollisionShape2D.scale = Vector2(
		Global.cellSize/2, Global.cellSize/2
	)
	
	print("Player inicizlization: OK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
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
		nX -= 1
		direction = 0
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_right"):
		nX += 1
		direction = 2
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_up"):
		nY -= 1
		direction = 1
		$moveTimer.start()
	elif Input.is_action_just_pressed("ui_down"):
		nY += 1
		direction = 3
		$moveTimer.start()
	
	checkMovement()
	moveToCoordinates()
	emit_signal("getPlayerCoords", positionX, positionY)


func _on_move_timer_timeout() -> void:
	if   direction == -1:
		pass
	elif direction == 0:
		nX -= 1
	elif direction == 1:
		nY -= 1
	elif direction == 2:
		nX += 1
	elif direction == 3:
		nY += 1
