extends KinematicBody2D

export (bool) var kill = false
var moveR = false
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
var P = Vector2()
var V = Vector2()
export (bool) var directionR = false
var speed = 80
var gravity = 400
var runs = false

func move(delta):
	if directionR:
		direction.x = 1
	else:
		direction.x = -1
	P = $"../Player".global_position
	V = global_position
	if abs(V.x - P.x) >= 200:
		runs =true
	else:
		runs = false
	if V.x - P.x < 0:
		direction.x = 1
	elif V.x - P.x > 0:
		direction.x = -1
	distance.x = speed*delta
	velocity.x = (direction.x*distance.x)/delta
	velocity.y = gravity 

func checkDirect():
	if velocity.x > 0:
		moveR = true
	elif velocity.x < 0:
		moveR = false
	if velocity.length()>0:
		if moveR and runs:
			speed =200
			$Anim.animation = "run_r"
		elif !moveR and runs:
			speed =200
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
	runs = false

func _physics_process(delta):
	if(!kill):
		checkDirect()
		move(delta)
		move_and_slide(velocity, Vector2(0, -1))
	

func dead():
	pass