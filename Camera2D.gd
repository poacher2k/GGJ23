extends Camera2D
func _exit_tree() -> void:
	for g in get_groups():
		remove_from_group(g)
