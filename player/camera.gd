extends Camera

func _process(_delta: float) -> void:
	get_tree().call_group("mirrors", "update_cam", global_transform)
