extends Node2D

@export var rows = 5
@export var cols = 3


# Called when the node enters the scene tree for the first time.
func _ready():
#	$TileMap.set_cells_terrain_path(0, [Vector2i(0, 0), Vector2i(1, 0)], 0, 0)
#	$TileMap.set_cell(0, Vector2i(1, 1), 0)
#	$TileMap.set_cell(0, Vector2i(0, 0), 0, Vector2i(0, 0))
#	$TileMap.set_cell(0, Vector2i(1, 0), 1, Vector2i(0, 0))
#	$TileMap.set_cell(0, Vector2i(2, 0), 2, Vector2i(0, 0))
#	$TileMap.set_cell(0, Vector2i(3, 0), 3, Vector2i(0, 0))
#	print($TileMap.get_used_cells(0))
#	pass # Replace with function body.
	setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup():
	for x in range(rows):
		for y in range(cols):
			var tile = get_random_tile()
			$TileMap.set_cell(0, Vector2i(x, y), tile, Vector2i(0, 0))
	

func get_random_tile():
	var num = randf()
	
	if num < 0.1:
		return 0
	elif num < 0.2:
		return 1
	elif num < 0.3:
		return 2
	
	return	3
		
