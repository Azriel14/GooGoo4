extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.has_method("pick_up"):
		body.pick_up(self)
		emit_signal("Picked_up")
