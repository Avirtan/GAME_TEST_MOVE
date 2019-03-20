extends Area2D

var dead = false
func _physics_process(delta):
	var r = get_overlapping_bodies()
	if(!dead):
		for i in r:
			if i.has_method("Set_dead"):
				$"../Anim".animation = "hit_l"
				i.Set_dead()
				dead = true
				#$"..".kil = true
	if($"../Anim".frame == 2 and dead ):
		$"../Anim".playing = false
		$"../Anim".animation = "stop_l"
		$"../Anim".frame = 0
