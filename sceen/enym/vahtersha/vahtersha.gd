extends KinematicBody2D

var moveR = false
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
export (bool) var directionR = false
var speed = 80
var gravity = 400
var runs = false

func checkDirect():
	if directionR:
		direction.x = 1
	else:
		direction.x = -1
	if velocity.x > 0:
		moveR = true
	elif velocity.x < 0:
		moveR = false
	if velocity.length()>0:
		if moveR and runs:
			speed =100
			$Anim.animation = "run_r"
		elif !moveR and runs:
			speed =100
			$Anim.animation = "run_l" 
		else:
			speed =50
			$Anim.animation = "hod" 
	elif velocity.length()==0:
		if moveR:
			pass
			#$Anim.animation = "stopr"
		else:
			pass
			#$Anim.animation = "stopl" 
func _ready():
	runs = !false

func _physics_process(delta):
	print(directionR)
	checkDirect()
	distance.x = speed*delta
	velocity.x = (direction.x*distance.x)/delta
	velocity.y = gravity 
	move_and_slide(velocity, Vector2(0, -1))

func dead():
	pass