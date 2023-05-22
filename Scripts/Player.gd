extends KinematicBody2D

export var speed = 200
export var health = 25
var motion = Vector2.ZERO
var screenSize = Vector2.ZERO
var lastDirection = Vector2.ZERO
var direction = Vector2.ZERO
var isMoving = false
var isDamageExecuting = false
var isShooting = false
var poop
onready var animation = $Animation
const bulletPath = preload("res://Scenes/Bullet.tscn")

func bang():
	speed = speed - speed/80
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	$Shoot.play()
	if direction == Vector2.UP:
		bullet.rotation_degrees = 0
	elif direction == Vector2.DOWN:
		bullet.rotation_degrees = 180
	elif direction == Vector2.LEFT:
		bullet.rotation_degrees = 270
	elif direction == Vector2.RIGHT:
		bullet.rotation_degrees = 90
	bullet.position = position
	bullet.velocity = direction
	pass

# Hurty
func _damage():
	if not isDamageExecuting and health > 0:
		isDamageExecuting = true
		health -= 1
		$Hurt.play()
		yield(get_tree().create_timer(1.5), "timeout")
		isDamageExecuting = false

func _physics_process(delta):
	# Movement + Footsteps
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		)

	if input_vector == Vector2.ZERO:
		isMoving = false
		motion = Vector2.ZERO
		$Footsteps.volume_db -= delta * 20
		if $Footsteps.volume_db < -30:
			$Footsteps.stop()
	else:
		motion = input_vector.normalized() * speed
		isMoving = true
		$Footsteps.volume_db += delta * 20
		if !$Footsteps.playing:
			$Footsteps.play()
		if $Footsteps.volume_db > 3:
			$Footsteps.volume_db = 3

	motion = move_and_slide(motion)

	# Direction
	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
		$Silvangoisse.flip_h = false
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
		$Silvangoisse.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
		$Silvangoisse.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
		$Silvangoisse.flip_h = true

	# Gun
	if not isShooting and Input.is_action_pressed("ui_shoot"):
		isShooting = true
		if direction == Vector2.UP:
			$Silvangoisse.flip_h = false
			bang()
		elif direction == Vector2.DOWN:
			animation.stop()
			$Silvangoisse.set_frame(19)
			$Silvangoisse.flip_h = false
			bang()
		elif direction == Vector2.LEFT:
			animation.stop()
			$Silvangoisse.set_frame(18)
			$Silvangoisse.flip_h = true
			bang()
		elif direction == Vector2.RIGHT:
			animation.stop()
			$Silvangoisse.set_frame(18)
			$Silvangoisse.flip_h = false
			bang()
		yield(get_tree().create_timer(0.65), "timeout")
		isShooting = false

	#Animation
	if isShooting == false:
		if isMoving:
			lastDirection = direction
			if direction == Vector2.UP:
				animation.play("WalkU")
			elif direction == Vector2.DOWN:
				animation.play("WalkD")
			else:
				animation.play("WalkLR")
		else:
			if lastDirection == Vector2.UP:
				animation.play("IdleU")
			elif lastDirection == Vector2.DOWN:
				animation.play("IdleD")
			else:
				animation.play("IdleLR")
				$Silvangoisse.flip_h = lastDirection == Vector2.LEFT

	#Dead lol
	if health == 0:
		poop = get_tree().reload_current_scene()
