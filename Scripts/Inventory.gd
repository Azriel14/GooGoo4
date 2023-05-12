extends Control

const inventoryHeight = 720
const animationDuration = 0.3
var isVisible = false
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
