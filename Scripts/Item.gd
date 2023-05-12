extends Area2D

var itemName
var itemQuantity

func _ready():
	var randVal = randi() % 3
	if randVal == 0:
		itemName = "Pistol"
	elif randVal == 1:
		itemName = "Bullets"
	$Sprite.texture= load("res://Assets/" + str(itemName) + ".png")
	var stackSize = int(JsonData.itemData[itemName]["Stack Size"])
	itemQuantity = randi() % stackSize + 1
	
	if stackSize == 1:
		$Label.visible = false
	else:
		$Label.text = String(itemQuantity)
		
#func add_item_quantity(amountToAdd)


		
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(self)
		emit_signal("Picked_up")
