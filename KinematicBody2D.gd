extends KinematicBody2D

const GRAVITY = 20
const ACC = 40
const SPEED_UPPER = 250
const JUMP_HEIGHT = -400
const UP = Vector2(0,-1)

var motion = Vector2()
var friction = false
var doubleJumped = false
var rewinded = false 

var motion_hist = Array()

func _physics_process(delta):
	if Input.is_action_pressed("ui_down") && motion_hist.size() > 0:
		rewinded = true
		$Sprite.animation = "fall"
		motion = motion_hist.pop_back() * Vector2(-1,-1)
	else:
		# Gravity
		motion.y += GRAVITY

		if Input.is_action_just_released("ui_down"):
			motion_hist.clear()
		# Controls
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACC , SPEED_UPPER)
			$Sprite.flip_h = false
			$Sprite.animation = "run"
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACC , -SPEED_UPPER)
			$Sprite.flip_h = true
			$Sprite.animation = "run" 
		else:
			motion.x = 0 
			$Sprite.animation = "idle"
			friction = true

		if is_on_floor():
			rewinded = false
			doubleJumped = false 
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
			if Input.is_action_just_pressed("ui_up"): 
				motion.y = JUMP_HEIGHT


		elif Input.is_action_just_pressed("ui_up") && !doubleJumped:
				doubleJumped = true
				motion.y = JUMP_HEIGHT/ 2 # Double jump

		else:
			motion.x = lerp(motion.x, 0, 0.1)
			$Sprite.animation = "jump" if motion.y < 0 else "fall"
		
		if motion.abs() > Vector2(0, 20) && !rewinded:
			motion_hist.append(Vector2(motion.x, motion.y -20))
		
	motion = move_and_slide(motion, UP)
	pass
