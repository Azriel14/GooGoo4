extends Control

const INVENTORY_HEIGHT = 720
const ANIMATION_DURATION = 0.3
var is_visible = false
var tween: Tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	set_process_input(true)
	set_process_unhandled_input(true)
	rect_position.y = get_viewport_rect().size.y

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		toggle_visibility()
		#set_process_input(false)
		set_process_unhandled_input(false)

func toggle_visibility():
	if is_visible:
		hide_inventory()
	else:
		show_inventory()

func hide_inventory():
	is_visible = false
	tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y + INVENTORY_HEIGHT, ANIMATION_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func show_inventory():
	is_visible = true
	tween.interpolate_property(self, "rect_position:y", rect_position.y, get_viewport_rect().size.y - INVENTORY_HEIGHT, ANIMATION_DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
