extends Area2D


func _physics_process(delta):
	var r = get_overlapping_bodies()
	#if r.size() == 0:
	#	prH = false
	#	prH_p = false
	for i in r:
		if i.get_name() == "Player":
			$"../body".disabled = true
