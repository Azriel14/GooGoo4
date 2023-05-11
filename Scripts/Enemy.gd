extends KinematicBody2D

export var pathToPlayer := NodePath()
export var detectionRange: float = 350
var motion := Vector2.ZERO
var originalPosition
var isSpoopying = false
var isNotSpoopying = false
onready var player := get_node(pathToPlayer)
onready var pathfinding = $Pathfinding
onready var animation = $Animation
onready var timer = $Timer

func _ready():
	_updatePathfinding()
	timer.connect("timeout", self, "_updatePathfinding")
	originalPosition = global_position
	
func _updatePathfinding():
	if player:
		pathfinding.set_target_location(player.global_position)

func _dontSpoop():
	if not isNotSpoopying:
		isNotSpoopying = true
		$Sound.stream = load("res://Assets/Sounds/EnemyIdle.wav")
		$Sound.play()
		yield(get_tree().create_timer(22.0), "timeout")
		isNotSpoopying = false

func _spoop():
	if not isSpoopying:
		isSpoopying = true
		$Sound.stream = load("res://Assets/Sounds/EnemyNotice.wav")
		$Sound.play()
		yield(get_tree().create_timer(7.0), "timeout")
		isSpoopying = false

func _physics_process(delta: float):
	# Movement
	if pathfinding.is_navigation_finished():
		return

	var direction := global_position.direction_to(pathfinding.get_next_location())
	var distance = global_position.distance_to(player.global_position)
	if distance > detectionRange:
		direction = global_position.direction_to(originalPosition)
		_dontSpoop()
	else:
		direction = global_position.direction_to(pathfinding.get_next_location())
		_spoop()
	var desiredMotion := direction * 150
	var steering := (desiredMotion - motion) * delta * 4.0
	motion += steering
	motion = move_and_slide(motion)

	# Animation
	if direction.y < -0.5:
		animation.play("DraggingU")
		$Infected.flip_h = false
	elif direction.x < 0:
		animation.play("DraggingLRD")
		$Infected.flip_h = true
	else:
		animation.play("DraggingLRD")
		$Infected.flip_h = false

	# Damage player
	var overlapping_bodies = $Hurtbox.get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			body._damage()
