extends Camera2D

var positionX
var positionY
var playerX
var playerY

var curZoom

@export var camSpeed = 1.0
@export var zoomSpeed = 1.0

func _showNewLevel():
	$lvlTransitionBG.modulate = Color(1, 1, 1, 1)
	$lvlTransitionBG/decayTimer.start()
	$lvlTransitionBG/decayTimer.wait_time = 0.09
	$lvlTransitionBG/Label.text = "NEW LEVEL REACHED"

func _showGameEnd():
	$lvlTransitionBG.modulate = Color(1, 1, 1, 1)
	$lvlTransitionBG/decayTimer.start()
	$lvlTransitionBG/decayTimer.wait_time = 1.3
	$lvlTransitionBG/Label.text = "GAME FINISHED"

func _showGameStart():
	$lvlTransitionBG.modulate = Color(1, 1, 1, 1)
	$lvlTransitionBG/decayTimer.start()
	$lvlTransitionBG/decayTimer.wait_time = 0.15
	$lvlTransitionBG/Label.text = "REACH 6 LEVEL"

func moveToCoordinates() -> void:
	global_position.x = \
	positionX * ( Global.cellSize + Global.gridLineSize)
	global_position.y = \
	positionY * ( Global.cellSize + Global.gridLineSize)

func _ready() -> void:
	positionX = 0
	positionY = 0
	playerX = 0
	playerY = 0
	get_tree().get_first_node_in_group("Player").getPlayerCoords.connect(_on_getting_player_coords)
	get_parent().showNewLevel.connect(_showNewLevel)
	get_parent().showGameEnd.connect(_showGameEnd)
	get_parent().showGameStart.connect(_showGameStart)
	print("Camera Inicialization OK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	curZoom = 1 + ( abs(playerX-positionX) \
	+ abs(playerY-positionY) ) * zoomSpeed
	zoom = Vector2(curZoom, curZoom)
	
	$ScoreLabel.text = "score="+str(Global.score)
	$PositionInfoLabel.text = \
	"X=" + str(playerX) + "; Y=" + str(playerY)
	$levelInfoLabel.text = \
	"level=" + str(Global.curLevel)
	$xpInfoLabel.text = \
	str(int(Global.score - Global.xpForPrev)) \
	+"/"+ str(int(Global.xpForLevels - Global.xpForPrev))
	
	positionX = lerp(1.0*positionX, 1.0*playerX, delta*camSpeed)
	positionY = lerp(1.0*positionY, 1.0*playerY, delta*camSpeed)
	
	moveToCoordinates()


func _on_getting_player_coords(x, y):
	playerX = x
	playerY = y


func _on_decay_timer_timeout() -> void:
	var cur = $lvlTransitionBG.modulate.r
	var amount = 0.07
	$lvlTransitionBG.modulate = Color(cur-amount, cur-amount, cur-amount, cur-amount)
	if cur <= 0.5:
		$lvlTransitionBG/decayTimer.stop()
		$lvlTransitionBG.modulate = Color(0, 0, 0, 0)
	print("OK Decay Timer")
