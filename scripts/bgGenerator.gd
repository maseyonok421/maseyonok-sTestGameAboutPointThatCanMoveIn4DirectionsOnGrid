extends Sprite2D

func drawGrid():
	
	var width  = ( Global.fullCellSize ) \
			   * ( Global.gridSize*2 + 1) + Global.gridLineSize-1
	var height = ( Global.fullCellSize ) \
			   * ( Global.gridSize*2 + 1) + Global.gridLineSize-1
	
	var bgImg = Image.create(width, height, false, Image.FORMAT_L8);
	for i in range(width):
		for j in range(height):
			if ( (i-Global.gridLineSize+Global.fullCellSize+1) % Global.fullCellSize > Global.cellSize ||
				 (j-Global.gridLineSize+Global.fullCellSize+1) % Global.fullCellSize > Global.cellSize ):
				bgImg.set_pixel(i, j, Color(1, 1, 1))
			else:
				bgImg.set_pixel(i, j, Color(0, 0, 0))
	
	texture = ImageTexture.create_from_image(bgImg)
	
	#position = Vector2(
		#-Global.fullCellSize/2-Global.gridLineSize/2+0.5,
		#-Global.fullCellSize/2-Global.gridLineSize/2+0.5
	#)
	position = Vector2(0, 0)
	global_position = Vector2(0, 0)


func redraw():
	print(global_position, ' ', position)
	drawGrid()
	print(global_position, ' ', position)


func _ready() -> void:
	drawGrid()
	get_parent().redrawGrid.connect(redraw)
