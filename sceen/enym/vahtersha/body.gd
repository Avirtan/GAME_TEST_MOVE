extends Area2D


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var r = get_overlapping_bodies()
	if(!$"..".kill):
		for  i in r:
			if i.get_name() == "Player":
				i.Set_dead()
				
