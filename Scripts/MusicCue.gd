extends Area2D

var musicPlaying

func _physics_process(_delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
	
	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			_da_music()
			
func _da_music():
	if not musicPlaying:
		musicPlaying = true
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(48.0), "timeout")
		musicPlaying = false
