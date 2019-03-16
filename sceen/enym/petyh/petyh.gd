extends KinematicBody2D


var velocity = Vector2()
var speed = 1
var get_col = null
var underatack = false
var sec = 0
export (bool) var isdead = false

func atack():
	$Anim.animation = "chinit"
	$leftM/CollisionShape2D.disabled = true
	$rightM/CollisionShape2D.disabled = true
	underatack = true

func pochinil():
	underatack = false
	$Anim.animation = "run"
	$leftM/CollisionShape2D.disabled = false
	$rightM/CollisionShape2D.disabled = false

func _physics_process(delta):
	if !isdead:
		if(underatack):
			sec+=0.1
			if(sec >= 10):
				pochinil()
				sec = 0	
		"""if(position.x-50 > 0):
			velocity.x -= speed
		else :
			velocity = Vector2()"""
		#print(get_viewport_rect().size.x)
		#velocity.x -= 0.1;
		move_and_slide(velocity)
	else:
		if($Anim.frame == 4):
			queue_free()

func dead():
	isdead = true
	$leftM/CollisionShape2D.disabled = true
	$rightM/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$Anim.animation = "dead"
	