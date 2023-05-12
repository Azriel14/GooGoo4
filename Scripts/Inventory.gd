extends Control

const inventoryHeight = 720
const animationDuration = 0.3
var isVisible = false
var tween: Tween
const SlotClass = preload("res://Scripts/Slot.gd")
onready var inventorySlots = get_node("TextureRect/GridContainer")
var holdingItem = null



func _ready():
	# Inventory management
	for invSlot in inventorySlots.get_children():
		invSlot.connect("gui_input", self, "slot_gui_input", [invSlot])
	
	# Animation for the menu to come into the scene
	tween = Tween.new()
	add_child(tween)
	set_process_input(true)
	set_process_unhandled_input(true)
	rect_position.y = get_viewport_rect().size.y

func slotGuiInput(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holdingItem != null:
				if !slot.item:
					slot.putIntoSlot(holdingItem)
					holdingItem = null
				else:
					var tempItem = slot.item
					slot.pickFromSlot()
					tempItem.global_position = event.global_position
					slot.putIntoSlot(holdingItem)
					holdingItem = tempItem
			elif slot.item:
				holdingItem = slot.item
				slot.pickFromSlot()
				holdingItem.global_position = get_global_mouse_position()

func _input(event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position()	
	
	if event.is_action_pressed("ui_inventory"):
		toggle_visibility()
		set_process_unhandled_input(false)

func toggle_visibility():
	if isVisible:
		hide_inventory()
	else:
		show_inventory()

func hide_inventory():
	isVisible = false
	tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y + inventoryHeight, animationDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func show_inventory():
	isVisible = true
	tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y - inventoryHeight, animationDuration, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()
