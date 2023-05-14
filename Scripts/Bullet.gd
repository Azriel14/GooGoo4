extends KinematicBody2D

var speed = 1000
var velocity = Vector2(0, 0)

func _physics_process(delta):
	var collisionInfo = move_and_collide(velocity.normalized() * delta * speed)
	var overlapping_bodies = $fuck.get_overlapping_bodies()
	if not overlapping_bodies:
		return

	for body in overlapping_bodies:
		if body.is_in_group("Enemy"):
			body._damage()
	if collisionInfo:
		queue_free()
