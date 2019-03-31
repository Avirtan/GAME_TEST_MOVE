extends KinematicBody2D

func _ready():
	pass # Replace with function body.

var speed = 400
var velocity = Vector2()
var moveR = false
var get_col = null
var p = Vector2()
var tr = 0
var runs = false

func start(pos,d, dir,napr,run):
	runs = run
	rotation = dir
	position = pos
	moveR = napr
	p = d
	if moveR:
		$Anim.animation = "run_r"
		if !runs:
			position.x +=95
			position.y -=80
			velocity = Vector2(speed, 0)
		else:
			$Anim.animation = "run_l"
			position.x +=55
			position.y -=100
			velocity = Vector2(0, -speed)
	else:
		$Anim.animation = "run_l"
		if !runs:
			position.x -=95
			position.y -=80
			velocity = Vector2(-speed, 0)
		"""else:
			$Anim.animation = "run_r"
			position.x -=75
			position.y -=80
			velocity = Vector2(0, -speed)"""
	if global_position.y < p.y and !runs:
		tr=2
	if global_position.y > p.y and !runs:
		tr=-1

func _physics_process(delta):
	if !runs:
		position.y +=tr
	if runs:
		position.y -=2
	#print("p: ",p.y," spell:",global_position.y)
	move_and_slide(velocity)
	if get_slide_count() != 0 :
		get_col = get_slide_collision(get_slide_count()-1)
	if get_col!= null:
		if get_col.collider.has_method("Set_dead"):
			get_col.collider.Set_dead()
			delete()
		delete()
	if $"../Player/Camera2D".global_position.x > global_position.x+800:
		delete()
	if $"../Player/Camera2D".global_position.x < global_position.x-800:
		delete()

func delete():
	queue_free()
