extends KinematicBody2D

var speed = 1000
var velocity = Vector2(0, 0)
export var bloodScene : PackedScene

func _physics_process(delta):
	var collisionInfo = move_and_collide(velocity.normalized() * delta * speed)
	var overlapping_bodies = $fuck.get_overlapping_bodies()
	if not overlapping_bodies:
		return

	for body in overlapping_bodies:
		if body.is_in_group("Enemy"):
			body._damage()
			var splat = bloodScene.instance() as Particles2D
			get_parent().add_child(splat)
			splat.global_position = collisionInfo.position
			splat.rotation = collisionInfo.normal.angle() + 135
	if collisionInfo != null:
		queue_free()
