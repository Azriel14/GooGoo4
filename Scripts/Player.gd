extends KinematicBody2D

export var speed = 200
var momentum = Vector2.ZERO
var screenSize = Vector2.ZERO
var lastDirection = Vector2.ZERO
var isMoving = false
onready var animation = $Animation

func _ready():
	screenSize = get_viewport_rect().size

func _physics_process(delta):
	# Movement
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	if input_vector == Vector2.ZERO:
		momentum = Vector2.ZERO
	else:
		momentum = momentum.move_toward(input_vector * speed, speed * delta)
	move_and_slide(momentum)

	# Animation
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
		$Silvangoisse.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
		$Silvangoisse.flip_h = true

	if direction != Vector2.ZERO:
		lastDirection = direction
		isMoving = true
		if direction == Vector2.UP:
			animation.play("WalkU")
		elif direction == Vector2.DOWN:
			animation.play("WalkD")
		else:
			animation.play("WalkLR")
	else:
		isMoving = false
		if lastDirection == Vector2.UP:
			animation.play("IdleU")
		elif lastDirection == Vector2.DOWN:
			animation.play("IdleD")
		else:
			animation.play("IdleLR")
			$Silvangoisse.flip_h = lastDirection == Vector2.LEFT
