extends KinematicBody2D

var Bullet = preload("res://sceen/enym/kachok/vistrel.tscn")

var moveR = false
var speed = 100
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
export (bool) var kil = false
export (bool) var directionR = false
export (bool) var see = false
export (bool) var dead = false
var gravity = 400
var time = -1
var shoot = false
var r = 4

func shoot():
	shoot = true
	if moveR:
		$Anim.animation = "had_r"
	else:
		$Anim.animation = "had_l"
	var b = Bullet.instance()
	b.start(self.global_position, rotation,moveR)
	get_parent().add_child(b)

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
		if moveR and !shoot:
			$Anim.animation = "run_r"
		elif !moveR and !shoot:
			$Anim.animation = "run_l" 
	elif velocity.x==0:
		if moveR and !shoot:
			$Anim.animation = "stop_r"
		elif !moveR and !shoot:
			$Anim.animation = "stop_l" 
	
func _ready():
	$Timer.start()

func _physics_process(delta):
	checkDirect()
	if $Timer.time_left >= 0.9 and  $Timer.time_left < 1:
		time+=1
	if time > r:
		r = rand_range(10,20)
		shoot()
		time = 0
	print(time)#$Timer.time_left)
	#print(rand_range(1,11))
	distance.x = speed*delta
	direction.x = 0
	velocity.x = (direction.x*distance.x)/delta
	velocity.y = gravity 
	#print(velocity.x)
	if shoot and $Anim.frame == 2:
		shoot = false
	move_and_slide(velocity, Vector2(0, -1))
