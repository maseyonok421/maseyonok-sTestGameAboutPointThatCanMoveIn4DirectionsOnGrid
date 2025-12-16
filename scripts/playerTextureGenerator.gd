extends Sprite2D


func _ready() -> void:
	
	var width  = Global.cellSize
	var height = Global.cellSize
	
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	for i in range(width):
		for j in range(height):
			img.set_pixel(i, j, Color(0, 1, 1))
	
	texture = ImageTexture.create_from_image(img)
