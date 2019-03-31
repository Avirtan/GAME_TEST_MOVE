extends KinematicBody2D

var Bullet = preload("res://sceen/enym/vahtersha/spell.tscn")

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
export (bool) var runs = false
var time = 0
var r = 4
var shoot = false

func shoot():
	if moveR and !runs:
		$Anim.animation = "spell_r"
	elif !moveR and !runs:
		$Anim.animation = "spell_l"
	var b = Bullet.instance()
	b.start(self.global_position,$"../Player".global_position, rotation,moveR,runs)
	get_parent().add_child(b)

func move(delta):
	"""if directionR:
		direction.x = 1
	else:
		direction.x = -1"""
	P = $"../Player".global_position
	V = global_position
	if runs and V.x - P.x > 0 and moveR:
		runs = false
	if runs and V.x - P.x < 0 and !moveR:
		runs = false
	if V.x - P.x < 0 and !runs:
		direction.x = 1
	elif V.x - P.x > 0 and !runs:
		direction.x = -1
	if abs(V.x - P.x) >= 670:
		runs = true
	distance.x = speed*delta
	velocity.x = (direction.x*distance.x)/delta
	
		

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
		elif !runs and !shoot:
			speed =50
			$Anim.animation = "hod" 
	"""elif velocity.length()==0:
		if moveR:
			pass
			#$Anim.animation = "stopr"
		else:
			pass
			#$Anim.animation = "stopl" """
func shooting(delta):
	if $Timer.time_left >= 0.9 and  $Timer.time_left < 1 and !runs:
		time+=1
	elif $Timer.time_left >= 0.5 and  $Timer.time_left < 1 and runs and !moveR:
		time+=1
	if  runs and moveR:
		time+=delta
	if time > r and !runs:
		r = rand_range(5,8)
		shoot()
		shoot = true
		time = 0
	if runs and moveR and time > 0.3:
		shoot()
		time = 0
	if runs and !moveR and time > 3:
		shoot()
		time = 0
	if(shoot and $Anim.frame == 1):
		shoot = false
	if Global.jump==1 and is_on_floor() and moveR and runs:
		jump()

func jump():
	if runs and is_on_floor():
		velocity.y =-350

func _ready():
	runs = false
	$Timer.start()

func _physics_process(delta):
	if(!kill):
		checkDirect()
		move(delta)
		shooting(delta)
		velocity.y += gravity*delta
		move_and_slide(velocity, Vector2(0, -1))
	if kill:
		$Anim.animation = "hod"
		velocity.x = 0
		velocity.y += gravity*delta
		move_and_slide(velocity, Vector2(0, -1))
	
		
	
	

func dead():
	pass