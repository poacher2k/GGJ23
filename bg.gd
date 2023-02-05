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
			var tile = get_random_bg_tile()
			$TileMap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 0))

func get_random_bg_tile():
	var num = randf()
	
	if num < 0.1:
		return 0
	elif num < 0.2:
		return 1
	elif num < 0.3:
		return 2
	
	return	3


func setup_ceiling():
	for x in range(rows):
		var tile = get_random_surrounding_tile()
		if tile == 3:
			$CeilingTilemap.set_cell(0, Vector2i(x, 0), tile, Vector2i(0, 0))
			$CeilingTilemap.set_cell(0, Vector2i(x, 1), tile, Vector2i(0, 1))
		else:
			$CeilingTilemap.set_cell(0, Vector2i(x, 0), tile, Vector2i(0, 0))


	
func setup_ground():
	var y = cols - 1
	for x in range(rows):
		var tile = get_random_surrounding_tile()
		$GroundTilemap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 0))
		
		if tile == 3:
			$GroundTilemap.set_cell(0, Vector2i(x, y - 1), tile, Vector2i(0, 0))
			$GroundTilemap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 1))
		else:
			$GroundTilemap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 0))


	
func get_random_surrounding_tile():
	if Global.end_time:
		return 0
		
	var num = randf()
	
	if num < 0.0005:
		return 3
	elif num < 0.01:
		return 2
	elif num < 0.06:
		return 1
	
	return	0
