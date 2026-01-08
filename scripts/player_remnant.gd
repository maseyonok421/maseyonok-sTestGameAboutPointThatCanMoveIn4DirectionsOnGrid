extends Sprite2D

@export var fadeAmount = 0.15;
@export var positionX = 0
@export var positionY = 0

func _ready() -> void:
	
	var width  = Global.cellSize
	var height = Global.cellSize
	
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	for i in range(width):
		for j in range(height):
			img.set_pixel(i, j, Color(0, 0.8, 1))
	
	texture = ImageTexture.create_from_image(img)

func moveToCoordinates() -> void:
	global_position.x = \
	positionX * ( Global.cellSize + Global.gridLineSize)
	global_position.y = \
	positionY * ( Global.cellSize + Global.gridLineSize)

func _process(delta: float) -> void:
	moveToCoordinates()
	if modulate.a <= 0:
		queue_free()


func _on_fader_timer_timeout() -> void:
	modulate.a -= fadeAmount
