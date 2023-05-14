extends Area2D


func _physics_process(_delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			get_tree().change_scene("res://Scenes/Ending.tscn")
