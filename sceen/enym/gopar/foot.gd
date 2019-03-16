extends Area2D

export (bool) var prF = false
export (bool) var prF_p = false

func _physics_process(delta):
	var r = get_overlapping_bodies()
	if r.size() == 0:
		prF = false
		prF_p = false
	for i in r:
		if i.get_name() == "Player":
			prF_p = true
		elif r.size() > 0:
			prF = true
