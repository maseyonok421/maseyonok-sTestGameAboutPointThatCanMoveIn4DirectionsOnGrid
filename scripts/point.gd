extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Area2D/CollisionShape2D.scale = Vector2(
		Global.cellSize/2, Global.cellSize/2
	)
	
	var width  = Global.cellSize
	var height = Global.cellSize
	
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	for i in range(width):
		for j in range(height):
			img.set_pixel(i, j, Color(1, 1, 0))
	
	$Sprite.texture = ImageTexture.create_from_image(img)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") :
		Global.score += 1
		queue_free()
