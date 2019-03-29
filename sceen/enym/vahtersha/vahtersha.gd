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
var time = -1
var r = 4

func shoot():
	if moveR:
		$Anim.animation = "spell_r"
	else:
		$Anim.animation = "spell_l"
	var b = Bullet.instance()
	b.start(self.global_position,$"../Player".global_position, rotation,moveR)
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
	if abs(V.x - P.x) >= 500:
		runs = true
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
	"""elif velocity.length()==0:
		if moveR:
			pass
			#$Anim.animation = "stopr"
		else:
			pass
			#$Anim.animation = "stopl" """

func _ready():
	runs = false
	$Timer.start()

func _physics_process(delta):
	#print(runs)
	if(!kill):
		checkDirect()
		move(delta)
		if $Timer.time_left >= 0.9 and  $Timer.time_left < 1:
			time+=1
		if time > r:
			r = rand_range(10,20)
			#print($"../Player".global_position)
			shoot()
			time = 0
		move_and_slide(velocity, Vector2(0, -1))
	

func dead():
	pass