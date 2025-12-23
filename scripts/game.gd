extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$bg.position += Vector2(
		Global.fullCellSize/2 + Global.gridLineSize/2-0.5,
		Global.fullCellSize/2 + Global.gridLineSize/2-0.5)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
