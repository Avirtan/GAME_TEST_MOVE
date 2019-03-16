extends Area2D

export(bool) var prL = false
export(bool) var prL_p = false
func _physics_process(delta):
	var r = get_overlapping_bodies()
	if r.size() == 0:
		prL = false
		prL_p = false
	for i in r:
		if i.get_name() == "right" or i.get_name() == "left":
			if !$"../../Player/right/righthit".disabled or !$"../../Player/left/lefthit".disabled :
				$"..".kil = true
				$"..".queue_free()
		elif  i.get_name() == "Player":
			prL_p = true
		else:
			if r.size() > 0:
				prL = true
