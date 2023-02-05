extends Node

var start_time = Time.get_ticks_msec()
var end_time : int
var has_begun_sequence = false

var best_time = 99999999999

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		reset()
	pass


func reset():
	if end_time:
		var score = end_time - start_time
		if score < best_time:
			best_time = score
	
		end_time = 0
	has_begun_sequence = false
	get_tree().change_scene_to_file("res://main.tscn")
	
