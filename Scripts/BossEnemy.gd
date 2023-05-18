extends KinematicBody2D

export var pathToPlayer := NodePath()
export var detectionRange: float = 1000
var motion := Vector2.ZERO
var originalPosition
var health = 5
var isDamageExecuting = false
onready var player := get_tree().get_root().get_node("Game").get_node("Player")
onready var pathfinding = $Pathfinding
onready var animation = $Animation
onready var timer = $Timer

func _ready():
	_update_path_finding()
	timer.connect("timeout", self, "_update_path_finding")
	originalPosition = global_position
	
func _update_path_finding():
	if player:
		pathfinding.set_target_location(player.global_position)

func _damage():
	if not isDamageExecuting and health > 0:
		isDamageExecuting = true
		health -= 1
		yield(get_tree().create_timer(0.25), "timeout")
		$Hurt.play()
		isDamageExecuting = false

func _physics_process(delta: float):
	#Dead lol
	if health == 0:
		queue_free()
		
	# Movement
	if pathfinding.is_navigation_finished():
		return

	var direction := global_position.direction_to(pathfinding.get_next_location())
	var distance = global_position.distance_to(player.global_position)
	if health == 5 and distance > detectionRange:
		direction = global_position.direction_to(originalPosition)
	else:
		direction = global_position.direction_to(pathfinding.get_next_location())
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
