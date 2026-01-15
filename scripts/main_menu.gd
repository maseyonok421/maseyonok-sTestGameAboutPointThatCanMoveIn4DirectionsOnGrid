extends Node2D

var curLbl = 0
var labels

@export var gameScene = preload("res://scenes/game.tscn").instantiate()
#@export var musScene  = load("res://scenes/mus_manager.tscn").instantiate()

func _ready() -> void:
	labels = [$newGame, $load, $exit]
	#get_tree().get_root().add_child(musScene)
	print("Main Menu Inicizlization OK")

func changeSceneTo(scn):
	var tree = get_tree()
	var curScene = tree.get_current_scene()
	tree.get_root().add_child(scn)
	tree.set_current_scene(scn)
	tree.get_root().remove_child(curScene)

func redrawLabels():
	for lbl in labels:
		lbl.modulate = Color(0.5, 0.5, 0.5)
	labels[curLbl].modulate = Color(1, 1, 1)
	

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_up"):
		curLbl -= 1
		if curLbl < 0: curLbl = 0
	if Input.is_action_just_pressed("ui_down"):
		curLbl += 1
		if curLbl > 2: curLbl = 2
	if Input.is_action_just_pressed("ui_accept"):
		if   curLbl == 0:
			changeSceneTo(gameScene)
		elif curLbl == 1:
			changeSceneTo(gameScene)
		else:
			get_tree().quit()
	
	
	redrawLabels()
