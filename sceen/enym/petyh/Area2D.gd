extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var r = get_overlapping_bodies()
	for  i in r:
		if i.get_name() == "Player" and !$"..".isdead:
			$"../Cbody".disabled = true
			i.Set_dead()
