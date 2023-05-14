extends StaticBody2D

func _physics_process(_delta):
	var alive = get_tree().get_nodes_in_group("Enemy").size()
	if alive == 0:
		queue_free()
