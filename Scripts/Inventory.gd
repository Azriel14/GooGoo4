extends Control

const inventoryHeight = 720
const animationDuration = 0.3
const numSlots = 6
var isVisible = false
var tween: Tween
var inventoryItems = []
var count = 0
var poop

func _ready():
	# Inventory management
	for i in range(numSlots):
		var inventorySlots = get_node("TextureRect/GridContainer/InventorySlot%d" % (i+1))
		inventoryItems.append(inventorySlots)
			
	# Animation
	tween = Tween.new()
	add_child(tween)
	set_process_input(true)
	set_process_unhandled_input(true)
	rect_position.y = get_viewport_rect().size.y

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		toggle_visibility()
		set_process_unhandled_input(false)

func toggle_visibility():
	if isVisible:
		isVisible = false
		poop = tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y + inventoryHeight, animationDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
		poop = tween.start()
	else:
		isVisible = true
		poop = tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y - inventoryHeight, animationDuration, Tween.TRANS_QUAD, Tween.EASE_IN)
		poop = tween.start()

func add_item(item):
	if count == 0:
		var new_item = item.duplicate()
		new_item.position = Vector2(165, 230)
		new_item.scale = Vector2(1.5, 1.5)
		add_child(new_item)
		count += 1
		item.queue_free()
	else:
		if typeof(get_child(0)) == typeof(item) and is_instance_valid(get_child(0)):
			count += 1
			for i in range(numSlots):
				var inventorySlot = inventoryItems[i]
				var countLabel = inventorySlot.get_node("Count%d" % (i+1))
				print(countLabel)
				if countLabel.text == "":
					countLabel.text = "2"
				else:
					countLabel.text = str(count)
			item.queue_free()



