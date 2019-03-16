extends Area2D

var dead = false
func _physics_process(delta):
	var r = get_overlapping_bodies()
	if(!dead):
		for  i in r:
			print(i.get_name())
			if i.get_name() == "right" or i.get_name() == "left":
				if !$"../../Player/right/righthit".disabled or !$"../../Player/left/lefthit".disabled :
					$"..".kil = true
					#$"..".queue_free()


