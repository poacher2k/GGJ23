extends Node2D

@export var rows = 5
@export var cols = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup():
	setup_bg()
	setup_ceiling()
	setup_ground()

func setup_bg():
	for x in range(rows):
		for y in range(cols):
			var tile = get_random_tile()
			$TileMap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 0))

func setup_ceiling():
	for x in range(rows):
		$CeilingTilemap.set_cell(0, Vector2i(x, 0), 1, Vector2i(0, 0))
	
	
func setup_ground():
	var y = cols - 1
	for x in range(rows):
		$GroundTilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))

func get_random_tile():
	var num = randf()
	
	if num < 0.1:
		return 0
	elif num < 0.2:
		return 1
	elif num < 0.3:
		return 2
	
	return	3
