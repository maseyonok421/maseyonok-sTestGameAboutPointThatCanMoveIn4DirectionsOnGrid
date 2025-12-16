extends Sprite2D


func _ready() -> void:
	var width  = ( Global.fullCellSize ) * 32
	var height = ( Global.fullCellSize ) * 32
	
	var bgImg = Image.create(width, height, false, Image.FORMAT_L8);
	for i in range(width):
		for j in range(height):
			if ( i % Global.fullCellSize > Global.cellSize ||
				 j % Global.fullCellSize > Global.cellSize ):
				bgImg.set_pixel(i, j, Color(1, 1, 1))
			else:
				bgImg.set_pixel(i, j, Color(0, 0, 0))
	
	texture = ImageTexture.create_from_image(bgImg)
