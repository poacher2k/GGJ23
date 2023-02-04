extends CanvasLayer

@onready var player

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score_text(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if not player:
		return
		
	offset.x = player.position.x - 320
	
func set_score_text(score: int):
	$Control/Label.text = str(score)

func set_player(_player):
	player = _player
