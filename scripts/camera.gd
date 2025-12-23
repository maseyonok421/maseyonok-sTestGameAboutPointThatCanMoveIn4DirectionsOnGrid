extends Camera2D

var positionX
var positionY

var playerX
var playerY

@export var camSpeed = 1.0

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
	print("Camera Inicialization OK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	get_tree().get_first_node_in_group("Player").getPlayerCoords.connect(_on_getting_player_coords)
	$ScoreLabel.text = str(Global.score)
	$PositionInfoLabel.text = \
	"X = " + str(playerX) + "; Y = " + str(playerY)
	
	positionX = lerp(1.0*positionX, 1.0*playerX, delta*camSpeed)
	positionY = lerp(1.0*positionY, 1.0*playerY, delta*camSpeed)
	
	moveToCoordinates()


func _on_getting_player_coords(x, y):
	playerX = x
	playerY = y
