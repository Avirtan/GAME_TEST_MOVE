extends KinematicBody2D

export (bool) var dead = false
export (bool) var left = false
export (bool) var right = false

var Bullet = preload("res://sceen/pers2D/bullet.tscn")
var Block = preload("res://sceen/pers2D/Metka.tscn")

var velocity = Vector2()
var moveR = true
var hit = false
var hitv = false
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
var time_spell = 0
var time_jump = 0
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
		dead = true
		$pers.disabled = true
		$death.disabled = false
		if moveR:
			$Anim.animation = 'dead_r'
		else:
			$Anim.animation = 'dead_l'
		#$Anim.animation = 'dead'
		velocity = Vector2(0,0)
	
func shoot():
	var b = Bullet.instance()
	b.start(self.global_position, rotation,moveR)
	get_parent().add_child(b)

func get_input(delta):
	velocity.x = 0
	run_l = Input.is_action_pressed('ui_left')
	run_r = Input.is_action_pressed('ui_right')
	hit_p = Input.is_action_just_pressed('hit')
	speel_p = Input.is_action_just_pressed('spell')
	jump = Input.is_action_just_pressed('ui_select')
	var jump_pressd = Input.is_action_pressed('ui_select')
	tp = Input.is_action_just_pressed("tp")
	spell_p = Input.is_action_just_pressed("spell")
	if !is_on_floor():
		if Global.jump ==0:
			Global.jump = 1
		#print(1)
		#if  !run_l and !run_r and velocity.y < 0:
		#$Anim.animation = "jump_ml" 
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
	if spell_p and is_on_floor() and !run_l and !run_r and time_spell > 0.8:
		spell = true
		time_spell = 0
		if moveR:
			$Anim.animation = "Spell_R"
		else :
			$Anim.animation = "Spell_L"
		hit = false
		shoot()
	if is_on_floor() and !hit and !spell and (!jump_pressd or time_jump > 0.08):
		jumping = true
		if time_jump < 0.08 and time_jump!=0:
			velocity.y = jump_speed-(jump_speed/3)
		elif time_jump >= 0.08:
			velocity.y = jump_speed
	if jump_pressd:
		time_jump +=delta
	else:
		time_jump = 0
	#print( time_jump)
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
		hitv = true
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
			if !stena and time <= 0:
				velocity.x -=run_speed
			if stena and time > 0.5:
				velocity.x -=run_speed
		elif hit and !is_on_floor() :
			velocity.x -=run_speed*2
		elif hit:
			velocity.x -=run_speed/1.5
		moveR = false 
	#print(time)
	if run_r :
		if !hit and !spell:
			if is_on_floor():
				$Anim.animation = "Run_R"
			elif !is_on_floor() and !hit and velocity.y < 0:
				$Anim.animation = "jump_r"
			#$Anim.animation = "Run_R"
			if !stena and time <= 0:
				velocity.x +=run_speed
			if stena and time > 0.5:
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
	if hit and $Anim.frame == 4:
			hit = false
			$rightA/righthit.disabled = true
			$leftA/lefthit.disabled = true
	if  $Anim.frame == 4 and hitv == true:
		hit = false
		hitv = false
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
	if(!dead):
		get_input(delta)
		if ($".".left or $".".right) and velocity.y > -100  and !is_on_floor():
			Global.jump = 0
			if time < 0:
				time = 0
			if($".".right and !hit):
				$Anim.animation = "Stena_R"
				stena = true
			elif($".".left and !hit):
				$Anim.animation = "Stena_L"
				stena = true
		else:
			stena = false
			time = -1
	else:
		if($Anim.frame == 4 and $Anim.playing):
			$Anim.stop()
	if stena:
		velocity.y += gravity/5 * delta
		time+=delta
	else:
		velocity.y += gravity * delta
	#print(Global.jump)
	if is_on_floor():
		Global.jump = 0
		otskok = false
		jumping = false
		time =0
	time_spell +=delta
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

func _on_Button_pressed():
	$pers.disabled = false
	$death.disabled = true
	dead = false
