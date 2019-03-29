extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var r = get_overlapping_bodies()
	for  i in r:
		if i.get_name() == "Player":
			if i.has_method("Set_dead"):
				i.Set_dead()
				$"..".queue_free()
