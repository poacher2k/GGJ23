extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var end = 23.123819232
	if Global.end_time:
		end = Global.end_time * 0.001
	$TimeLabel.text = "%2.2f s" % end
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
