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
	if G.x - P.x < 0 and $".".see:
		direction.x = 1
	elif G.x - P.x > 0 and $".".see:
		direction.x = -1
	elif !$".".directionR and !$".".see :
		direction.x = -1
	else:
		direction.x = 1
	
	

func _physics_process(delta):
	#print(dead)
	if !kil and !dead:
		move()
		checkDirect()
		if !$".".see:
			distance.x = speed*delta
		else:
			distance.x = speed*4*delta
		velocity.x = (direction.x*distance.x)/delta
		velocity.y = gravity 
		move_and_slide(velocity, Vector2(0, -1))
	elif dead:
		if $Anim.frame == 3:
			queue_free()
func dead():
	if moveR:
		$Anim.animation = "dead_r"
	else:
		$Anim.animation = "dead_l"
	dead = true
	