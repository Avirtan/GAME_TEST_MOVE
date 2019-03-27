extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var r = get_overlapping_bodies()
	for  i in r:
		if !i.has_method("dead")  and i.get_name() != "Player" and r.size()==2 :
			$"..".directionR = false
