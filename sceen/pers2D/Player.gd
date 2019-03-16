extends KinematicBody2D


var Bullet = preload("res://sceen/pers/bullet.tscn")
var speed = 250
var velocity = Vector2()
var moveR = true
var hit = false
var spell = false
var get_col = null
export (bool) var dead = false
var kast = 0

func Set_dead():
	if(!dead):
		$Anim.animation = 'dead'
		velocity = Vector2(0,0)
		dead = true
	
func shoot():
	var b = Bullet.instance()
	b.start(self.global_position, rotation,moveR)
	get_parent().add_child(b)

func get_input():
	velocity = Vector2() 
	if Input.is_action_pressed('ui_right') and !hit and !spell:
		velocity.x += 1
	if Input.is_action_pressed('ui_left') and !hit and !spell:
		velocity.x -= 1
	if Input.is_action_pressed('ui_down') and !hit and !spell:
		velocity.y += 1
	if Input.is_action_pressed('ui_up') and !hit and !spell:
		velocity.y -= 1
	if Input.is_action_just_pressed('hit') and !spell :
		hit = true
		spell = false
	if Input.is_action_just_pressed('spell') and !hit and kast == 0:
		kast = 1
		spell = true
		hit = false
		shoot()
	if velocity.length() > 0 :
		if velocity.x < 0:
			$Anim.animation = "Run_L"
			moveR = false
		if velocity.x > 0 :
			$Anim.animation = "Run_R"
			moveR = true
		if velocity.y < 0 or velocity.y > 0:
			if moveR:
				$Anim.animation = "Run_R"
			else:
				$Anim.animation = "Run_L"
		velocity = velocity.normalized() * speed
	else:
		if spell:
			if moveR:
				$Anim.animation = "Spell_R"
				if($Anim.frame == 2):
					kast = 0
					spell = false
			else :
				$Anim.animation = "Spell_L"
				if($Anim.frame == 2):
					kast = 0
					spell = false
		elif hit:
			if moveR:
				$Anim.animation = "hit_R"
				$right/righthit.disabled = false
				check_slid()
				if($Anim.frame == 4):
					hit = false
					$right/righthit.disabled = true
			else :
				$Anim.animation = "hit_L"
				$left/lefthit.disabled = false
				check_slid()
				if($Anim.frame == 4):
					hit = false
					$left/lefthit.disabled = true
		else:
			if moveR:
				$Anim.animation = "Stop_R"
			else:
				$Anim.animation = "Stop_L"


func _physics_process(delta):
	if(!dead):
		get_input()
	else:
		if($Anim.frame == 4 and $Anim.playing):
			$Anim.stop()
	check_slid()
	move_and_slide(velocity,Vector2(0,-1))

func check_slid():
	if get_slide_count() != 0 :
		get_col = get_slide_collision(get_slide_count()-1)
	if get_col != null:
		"""if get_col.collider.has_method('kill'):
			get_col.collider.kill(velocity)"""
		if get_col.collider.has_method('Move_block'):
			get_col.collider.Move_block(velocity)
		#print(get_col)
		get_col = null

func _on_Area2D_body_entered(body):
	print(body)
	
