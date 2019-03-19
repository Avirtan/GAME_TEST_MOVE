extends Area2D


func _process(delta):
	var r = get_overlapping_bodies()
	for i in r:
		if i.get_name() == "right" or i.get_name() == "left":
			$"../".dead()
		r = null

