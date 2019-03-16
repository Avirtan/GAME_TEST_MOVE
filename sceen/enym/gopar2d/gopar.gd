extends KinematicBody2D

var  velocity = Vector2(0,0)
var moveR = false
var speed = 100
var l = 0
var top = false
var P = Vector2()
var G = Vector2()
export (bool) var kil = false

func checkDirect():
	if velocity.x > 0:
		moveR = true
		$hitR/ChitR.disabled = false
		$hitL/ChitL.disabled = true
	elif velocity.x < 0:
		moveR = false
		$hitR/ChitR.disabled = true
		$hitL/ChitL.disabled = false
	if velocity.length()>0:
		if moveR:
			$Anim.animation = "run_r"
		else:
			$Anim.animation = "run_l" 
	elif velocity.length()==0:
		if moveR:
			$Anim.animation = "stopr"
		else:
			$Anim.animation = "stopl" 

func move():
	P = $"../Player".global_position
	G = global_position
	
func _physics_process(delta):
	move()
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	velocity = Vector2()
