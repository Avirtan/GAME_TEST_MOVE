extends KinematicBody2D


var moveR = false
var speed = 100
var l = 0
var top = false
var P = Vector2()
var G = Vector2()
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
export (bool) var kil = false
export (bool) var directionR = false
export (bool) var see = false
export (bool) var dead = false
var gravity = 400


func checkDirect():
	if velocity.x > 0:
		$"hitl/hit".disabled = true
		$"hitr/hit".disabled = false
		moveR = true
	elif velocity.x < 0:
		$"hitr/hit".disabled = true
		$"hitl/hit".disabled = false
		moveR = false
	if velocity.x!=0:
		if moveR:
			$Anim.animation = "run_r"
		else:
			$Anim.animation = "run_l" 
	elif velocity.x==0:
		if moveR:
			$Anim.animation = "stop_r"
		else:
			$Anim.animation = "stop_l" 
	
func _physics_process(delta):
	checkDirect()
	distance.x = speed*delta
	direction.x = -1
	velocity.x = (direction.x*distance.x)/delta
	velocity.y = gravity 
	print(velocity.x)
	move_and_slide(velocity, Vector2(0, -1))
