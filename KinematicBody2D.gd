extends KinematicBody2D

const GRAVITY = 20
const ACC = 40
const SPEED_UPPER = 250
const JUMP_HEIGHT = -500
const UP = Vector2(0,-1)
var motion = Vector2()

var friction = false

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY
	
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
		if friction == true:
			
			motion.x = lerp(motion.x, 0, 0.2)
		if Input.is_action_just_pressed("ui_up"): 
		
			motion.y = JUMP_HEIGHT
	else:
		motion.x = lerp(motion.x, 0, 0.1)
		
		$Sprite.animation = "jump" if motion.y < 0 else "fall"
	
	motion = move_and_slide(motion, UP)
	
	pass
