extends Area2D

var itemName
var itemQuantity

func _ready():
	var rand_val = randi() % 2
	if rand_val == 0:
		itemName = "Pistol"
	else:
		itemName = "Bullets"
	
	$Sprite.texture = load("res://Assets/" + itemName + ".png")
	var stackSize = int(JsonData.itemData[itemName]["StackSize"])
	itemQuantity = randi() % stackSize + 1
	
	if stackSize == 1:
		$Label.visible = false
	else:
		$Label.text = String(itemQuantity)
		
func add_item_quantity(amountToAdd):
	itemQuantity += amountToAdd
	$Label.text = String(itemQuantity)
	
func decrease_item_quantity(amountToRemove):
	itemQuantity -= amountToRemove
	$Label.text = String(itemQuantity)
