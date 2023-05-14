extends CanvasLayer

onready var label1 = $Label
onready var label2 = $Label2
onready var label3 = $Label3
onready var player = $"../Player"

func _physics_process(_delta):
	var health = player.health
	var speed = player.speed
	var alive = get_tree().get_nodes_in_group("Enemy").size()
	label1.text = "Health: %d" % health
	label2.text = "Speed: %d" % speed
	label3.text = "Enemies left: %d" % alive
