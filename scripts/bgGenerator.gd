extends Sprite2D


func _ready() -> void:
	
	print(Global.fullCellSize)
	
	var width  = ( Global.fullCellSize ) * 9
	var height = ( Global.fullCellSize ) * 9
	
	var bgImg = Image.create(width, height, false, Image.FORMAT_L8);
	for i in range(width):
		for j in range(height):
			if ( i % Global.fullCellSize > Global.cellSize ||
				 j % Global.fullCellSize > Global.cellSize ):
				bgImg.set_pixel(i, j, Color(1, 1, 1))
			else:
				bgImg.set_pixel(i, j, Color(0, 0, 0))
	
	texture = ImageTexture.create_from_image(bgImg)
	
	position = Vector2(
		-Global.fullCellSize/2,
		-Global.fullCellSize/2
	)
