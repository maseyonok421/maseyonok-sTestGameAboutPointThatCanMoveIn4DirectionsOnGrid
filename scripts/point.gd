extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var width  = Global.cellSize
	var height = Global.cellSize
	
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	for i in range(width):
		for j in range(height):
			img.set_pixel(i, j, Color(1, 1, 0))
	
	$Sprite.texture = ImageTexture.create_from_image(img)
