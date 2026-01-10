extends ProgressBar


func _ready() -> void:
	print("XpPB Inicialization OK")

func _process(delta: float) -> void:
	value = ((Global.score*1.0 - Global.xpForPrev*1.0) \
	/ (Global.xpForLevels*1.0 - Global.xpForPrev*1.0)) * 100.0
