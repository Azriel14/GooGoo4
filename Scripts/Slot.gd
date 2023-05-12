extends Panel

var itemClass = preload("res://Scenes/Item.tscn")
var item = null

func _ready():
	if randi() % 2 == 0:
		item = itemClass.instance()
		add_child(item)
