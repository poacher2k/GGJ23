extends Node2D

# How many should there be on each side? Must be even!
@export var bgInstances = 4
@export var bgScene : PackedScene;

var allScenes : Array[Node2D]
var prevBgIndex = 0
var bgWidth = 320

# Called when the node enters the scene tree for the first time.
func _ready():
	if bgInstances % 2 != 0:
		bgInstances = bgInstances + 1
	
	createBgInstances()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	
	

func _physics_process(delta):
	var currentBgIndex = floor($Player.position.x / bgWidth)
	
	if currentBgIndex > prevBgIndex:
		var first = allScenes.pop_front();
		var last = allScenes.back()
		first.position.x = last.position.x + bgWidth
		allScenes.push_back(first)
	elif currentBgIndex < prevBgIndex:
		var last = allScenes.pop_back()
		var first = allScenes.front();
		last.position.x = first.position.x - bgWidth
		allScenes.push_front(last)

	
	prevBgIndex = currentBgIndex

func createBgInstances():
	bgWidth = $BG.get_node("Ceiling/CollisionShape2D").get_shape().extents.x * 2
	var half = bgInstances / 2
	
	for i in range(half):
		var n = bgScene.instantiate()
		n.position.x = (bgWidth * (i + 1) * -1)
		allScenes.append(n)
		%GameBounds.add_child(n)
	
	var bg = $BG;
	allScenes.append(bg)
	remove_child(bg)
	%GameBounds.add_child(bg)
		
	for i in range(half):
		var n = bgScene.instantiate()
		n.position.x = bgWidth * (i + 1)
		allScenes.append(n)
		%GameBounds.add_child(n)
