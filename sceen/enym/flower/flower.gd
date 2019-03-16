extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dead = false
func _ready():
	pass

func _physics_process(delta):
	var r = get_overlapping_bodies()
	if(!dead):
		for  i in r:
			if i.get_name() == "right" or i.get_name() == "left":
				if !$"../Player/right/righthit".disabled or !$"../Player/left/lefthit".disabled :
					queue_free()
			else:
				if i.has_method("Set_dead"):
					$Anim.playing = true
					i.Set_dead()
					dead = true
	if($Anim.frame == 4):
		$Anim.playing = false
		$Anim.frame = 0


