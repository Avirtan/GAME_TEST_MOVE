extends Area2D

var f = false

func _physics_process(delta):
	var r = get_overlapping_bodies()
	for  i in r:
		if !i.has_method("dead")  and i.get_name() != "Player" and r.size()==1 and i.get_name() != "Petyh" and i.get_name() != "Gopnik":
			f = true
		if i.get_name() == "Player" and r.size() == 1:
			f = false
			"""$"..".left = true
		else:
			$"..".left = false
			$"..".right = false"""
	if r.size()==0:
		f = false
	if f:
		$"..".left = true
	else:
		$"..".left = false
	