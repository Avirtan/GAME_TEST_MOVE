extends KinematicBody2D

func _ready():
	pass # Replace with function body.

var speed = 500
var velocity = Vector2()
var moveR = false
var get_col = null
func start(pos, dir,napr):
	rotation = dir
	position = pos
	moveR = napr
	if moveR:
		$AnimatedSprite.animation = "move_r"
		position.x +=100
		velocity = Vector2(speed, 0)
	else:
		$AnimatedSprite.animation = "move_l"
		position.x -=100
		velocity = Vector2(-speed, 0)

func _physics_process(delta):
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