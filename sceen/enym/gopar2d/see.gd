extends Area2D

func _physics_process(delta):
	var r = get_overlapping_bodies()
	for i in r:
		if r.size() >= 2 and i.get_name()== "Player":
			$"..".see = true
		elif r.size() <= 1:
			$"..".see = false
		
