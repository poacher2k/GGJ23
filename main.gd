extends Node2D

# How many should there be on each side? Must be even!
@export var bgInstances = 4
@export var bgScene : PackedScene;
@export var playerScene : PackedScene;
@export var itemScene : PackedScene;

var allScenes : Array[Node2D]
var prevBgIndex = 0
var bgWidth = 320

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	if bgInstances % 2 != 0:
		bgInstances = bgInstances + 1
	
	player = playerScene.instantiate()
	add_child(player)
	
	$UI.set_player(player)
	
	createBgInstances()
	
	Global.start_time = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	
	

func _physics_process(delta):
	var currentBgIndex = floor($Player.position.x / bgWidth)
	
	if currentBgIndex != prevBgIndex:
		if currentBgIndex > prevBgIndex:
			var first = allScenes.pop_front();
			var last = allScenes.back()
			first.position.x = last.position.x + bgWidth
			allScenes.push_back(first)
			first.setup()
		elif currentBgIndex < prevBgIndex:
			var last = allScenes.pop_back()
			var first = allScenes.front();
			last.position.x = first.position.x - bgWidth
			allScenes.push_front(last)
			last.setup()
			
		prevBgIndex = currentBgIndex
		maybeSpawnItem(currentBgIndex)

func createBgInstances():
	var bg = bgScene.instantiate();
	
	bgWidth = bg.get_node("Ceiling/CollisionShape2D").get_shape().extents.x * 2
	var half = bgInstances / 2
	
	for i in range(half):
		var n = bgScene.instantiate()
		n.position.x = (bgWidth * (i + 1) * -1)
		allScenes.append(n)
		%GameBounds.add_child(n)
	
	allScenes.append(bg)
	%GameBounds.add_child(bg)
	
	
	for i in range(half):
		var n = bgScene.instantiate()
		n.position.x = bgWidth * (i + 1)
		allScenes.append(n)
		%GameBounds.add_child(n)

var considered_indexes = {}
var chance_increaase_per_no = 0.15
var chance_for_item = 1

func maybeSpawnItem(index: int):
	if Global.end_time:
		return
		
	print(considered_indexes.has(index))
	if considered_indexes.has(index):
		return
	
	considered_indexes[index] = true
	
	if randf() <= chance_for_item:
		print("Spawning!")
		chance_for_item = 0
		spawn_item(index)
	else:
		print("No spawn")
		
		chance_for_item += chance_increaase_per_no
	
	
func spawn_item(index):
	var newItem = itemScene.instantiate()
	var lastBg = allScenes.back()
	newItem.position.x = lastBg.position.x + randf_range(0, bgWidth)
	newItem.position.y = 32 + randf_range(0, 128)
	%Items.add_child(newItem)
