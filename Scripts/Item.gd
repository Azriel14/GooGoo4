extends Node2D

func _ready():
	if randi() % 2 == 0:
		$TextureRect.texture = load("res://Assets/menu_knowledge_01017.png")
	else:
		$TextureRect.texture = load("res://Assets/QuicksilverBullets.webp")
	
