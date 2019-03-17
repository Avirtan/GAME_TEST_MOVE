extends KinematicBody2D

export (bool) var dead = false
export (bool) var left = false
export (bool) var right = false

var Bullet = preload("res://sceen/pers2D/bullet.tscn")
var Block = preload("res://sceen/pers2D/Metka.tscn")

var velocity = Vector2()
var moveR = true
var hit = false
var spell = false
var get_col = null
var hit_move = false
var jump_speed = -700
var gravity = 1200
var jumping = false
var run_speed = 500
var coordinat = null
var bl = null
var otskok = false
var time = 0
var otskok_r = null 

var run_l =null
var run_r =null
var hit_p =null
var speel_p = null
var jump =null
var tp = null
var spell_p = null
var stena = false

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
	velocity.x = 0
	run_l = Input.is_action_pressed('ui_left')
	run_r = Input.is_action_pressed('ui_right')
	hit_p = Input.is_action_just_pressed('hit')
	speel_p = Input.is_action_just_pressed('spell')
	jump = Input.is_action_just_pressed('ui_select')
	tp = Input.is_action_just_pressed("tp")
	spell_p = Input.is_action_just_pressed("spell")
	if !is_on_floor():
		#print(1)
		#if  !run_l and !run_r and velocity.y < 0:
		#	$Anim.animation = "jump_ml" 
		if !run_l and !run_r and !moveR and velocity.y > 0 and !hit:
			$Anim.animation = "fall_l"
		elif !run_l and !run_r and moveR and velocity.y > 0 and !hit:
			$Anim.animation = "fall_r"
		elif moveR and run_r and !hit and velocity.y > 0:
			$Anim.animation = "fall_r"
		elif !moveR and run_l and !hit and velocity.y > 0:
			$Anim.animation = "fall_l"
		elif !run_l and !run_r and moveR and velocity.y < 0 and !hit:
			$Anim.animation = "jump_r"
		elif !run_l and !run_r and !moveR and velocity.y < 0 and !hit:
			$Anim.animation = "jump_l"
	if $".".right and !is_on_floor() and jump and !run_l and !run_r:
		otskok = true
	if $".".left and !is_on_floor() and jump and !run_l and !run_r:
		otskok = true
	if spell_p and is_on_floor() and !run_l and !run_r:
		spell = true
		if moveR:
			$Anim.animation = "Spell_R"
		else :
			$Anim.animation = "Spell_L"
		hit = false
		shoot()
	if jump and is_on_floor() and !hit and !spell:
		jumping = true
		velocity.y = jump_speed
	if tp:
		if coordinat == null:
			bl = Block.instance()
			
			bl.set_cord(global_position)
			get_parent().add_child(bl)
			coordinat = global_position
		else:
			global_position = coordinat
			if bl!=null:
				bl.queue_free()
				bl = null
			coordinat = null
	if hit_p and !$".".left and !$".".right and is_on_floor():
		hit = true
		if moveR:
			$Anim.animation = "hit_R"
			$rightA/righthit.disabled = false
		elif !moveR:
			$Anim.animation = "hit_L"
			$leftA/lefthit.disabled  = false
	elif hit_p and !$".".left and !$".".right and !is_on_floor():
		hit = true
		if moveR:
			$Anim.animation = "hitv_r"
		else:
			$Anim.animation = "hitv_l"
				
		$rightA/righthit.disabled = false
		$leftA/lefthit.disabled  = false
	if run_r and hit_p and !hit and !$".".left and !$".".right:
		hit = true
		$Anim.animation = "hit_R"
		$rightA/righthit.disabled = false
	if run_l and hit_p and !hit and !$".".left and !$".".right:
		hit = true
		$Anim.animation = "hit_L"
		$leftA/lefthit.disabled = false

	if run_l :
		if !hit and !spell:
			if is_on_floor():
				$Anim.animation = "Run_L"
			elif !is_on_floor() and !hit and velocity.y < 0:
				$Anim.animation = "jump_l"
			velocity.x -=run_speed
		elif hit and !is_on_floor() :
			velocity.x -=run_speed*2
		elif hit:
			velocity.x -=run_speed/1.5
		moveR = false 
	if run_r :
		if !hit and !spell:
			if is_on_floor():
				$Anim.animation = "Run_R"
			elif !is_on_floor() and !hit and velocity.y < 0:
				$Anim.animation = "jump_r"
			#$Anim.animation = "Run_R"
			velocity.x +=run_speed
		elif hit and !is_on_floor() :
			velocity.x +=run_speed*2
		elif hit:
			velocity.x +=run_speed/1.5
		moveR = true 
	
	if !run_l and !run_r and !hit and !spell:
		if moveR and is_on_floor():
			$Anim.animation = "Stop_R"
		elif !moveR and is_on_floor():
			$Anim.animation = "Stop_L"
	if((hit and $Anim.frame == 4)or(!is_on_floor() and $Anim.frame == 2) ):
			hit = false
			$rightA/righthit.disabled = true
			$leftA/lefthit.disabled = true
	if( spell and $Anim.frame == 2):
			spell = false
	if $".".left and !is_on_floor() and jump and run_r:
		velocity.x = run_speed*10
		velocity.y = -run_speed*1.2
	if $".".right and !is_on_floor() and jump and run_l:
		velocity.x = -run_speed*10
		velocity.y = -run_speed*1.2
func _physics_process(delta):
	"""if(!dead):
		get_input()
	else:
		if($Anim.frame == 4 and $Anim.playing):
			$Anim.stop()
	check_slid()"""
	#if (!otskok):
	get_input()
	"""if otskok :
		time +=delta
		if $".".left and otskok_r == null:
			moveR = !moveR
			otskok_r = false
		elif $".".right and otskok_r == null:
			moveR = !moveR
			otskok_r = true
		if otskok_r and $".".left:
			time = 2
		elif !otskok_r and $".".right:
			time = 2
		if otskok_r and time < 0.3:
			velocity.x -=run_speed/15
			#velocity.y -=gravity/5 * delta
			velocity.y -=run_speed/5
		elif !otskok_r and time < 0.3:
			velocity.x +=run_speed/15
			#velocity.y -=gravity/5 * delta
			velocity.y -=run_speed/5
		if time > 1 or is_on_floor():
			velocity.y +=run_speed
			#velocity.y +=gravity * delta
			otskok = false
			otskok_r = null
			time = 0
		if moveR and velocity.y < 0:
			$Anim.animation = "jump_r"
		elif !moveR and velocity.y < 0:
			$Anim.animation = "jump_l"
		elif moveR and velocity.y > 0:
			$Anim.animation = "fall_r"
		elif !moveR and velocity.y > 0:
			$Anim.animation = "fall_l"
		#velocity.y -=gravity/12 * delta
		#velocity.y +=run_speed/12#gravity * delta
		velocity.y +=run_speed/12"""
	if ($".".left or $".".right) and velocity.y > -100  and !is_on_floor():
		#print($".".left)
		if($".".right and !hit):
			$Anim.animation = "Stena_R"
		elif($".".left and !hit):
			$Anim.animation = "Stena_L"
		stena = true
		#velocity.y += gravity/5 * delta
	else :
	#elif !$".".left and !$".".right and  !is_on_floor():
		stena = false
		
	if stena:
		velocity.y += gravity/8 * delta
	else:
		velocity.y += gravity * delta
	if is_on_floor():
		otskok = false
		jumping = false
		time =0
	velocity = move_and_slide(velocity, Vector2(0, -1))
	

func check_slid():
	if get_slide_count() != 0 :
		get_col = get_slide_collision(get_slide_count()-1)
	if get_col != null:
		"""if get_col.collider.has_method('kill'):
			get_col.collider.kill(velocity)"""
		if get_col.collider.has_method('Move_block'):
			get_col.collider.Move_block(velocity)
		get_col = null

func _on_Area2D_body_entered(body):
	pass
	#print(body)
	
