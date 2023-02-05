extends Node2D

var single_vine_height = 8

@export var vine_variations : Array[CanvasTexture] = []

# Called when the node enters the scene tree for the first time.
func _ready():
#	spawn_stuff()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_stuff(vineLength: float):
	var vines = ceil(vineLength / single_vine_height)
	
	for i in range(vines):
		var vineVar = vine_variations[randi() % vine_variations.size()]
		var v = Sprite2D.new()
		v.position.y = -i * single_vine_height
		v.texture = vineVar
		add_child(v)
		
