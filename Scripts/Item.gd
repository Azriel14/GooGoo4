extends Area2D

func _physics_process(_delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return

	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			add_to_inventory()

func add_to_inventory():
	var inventory = get_node("../../Hud + Inventory/Inventory")
	inventory.add_item(self)

