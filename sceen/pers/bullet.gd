extends KinematicBody2D


var speed = 500
var velocity = Vector2()
var moveR = false
var get_col = null
func start(pos, dir,napr):
	rotation = dir
	position = pos
	moveR = napr
	if moveR:
		position.x +=80
		velocity = Vector2(speed, 0)
	else:
		position.x -=90
		velocity = Vector2(-speed, 0)

func _physics_process(delta):
	move_and_slide(velocity)
	if get_slide_count() != 0 :
		get_col = get_slide_collision(get_slide_count()-1)
	if get_col!= null:
		if get_col.collider.has_method('atack'):
			get_col.collider.atack()
			delete()
		delete()
	"""if $"../Player/Camera2D".global_position.x > global_position.x+800:
		delete()
	if $"../Player/Camera2D".global_position.x < global_position.x-800:
		delete()"""

func delete():
	queue_free()

func _on_Visibility_screen_exited():
	queue_free()
