extends CanvasLayer

onready var label = $Label
onready var player = $"../Player"

func _physics_process(_delta):
	var health = player.health
	label.text = "%d Health" % health
