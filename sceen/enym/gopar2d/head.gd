extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#export (bool) var prH = false
#export (bool) var prH_p = false

func _physics_process(delta):
	var r = get_overlapping_bodies()
	#if r.size() == 0:
	#	prH = false
	#	prH_p = false
	for i in r:
		if i.get_name() == "Player":
			$"../Cbody".disabled = true
			#prH_p = true
		#elif r.size() > 0:
			#prH = true
