extends Area2D


func _physics_process(delta):
	var r = get_overlapping_bodies()
	if r.size() == 0:
		$"..".directionR = true
