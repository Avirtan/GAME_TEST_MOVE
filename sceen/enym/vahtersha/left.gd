extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var r = get_overlapping_bodies()
	if(!$"..".kill):
		for  i in r:
			if !i.has_method("dead")  and i.get_name() != "Player" and r.size()==2:
				$"..".directionR = true
				$"..".runs = false
			elif i.get_name() == "Player":
				i.Set_dead()
				$"..".kill = true
				$"../Anim".animation = "hit_l"
	if($"../Anim".frame == 2 and $"..".kill):
		$"../Anim".animation = "hod"
		$"../Anim".frame = 0
		$"../Anim".playing = false
