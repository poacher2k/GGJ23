extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var end = 23.123819232
	if Global.end_time:
		end = Global.end_time * 0.001
	var tex = "%2.2f s" % end
	
	if Global.best_time < 99999999999:
		tex = tex + " (best time %2.2f s)" % Global.best_time
	
	$TimeLabel.text = tex


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.reset()

