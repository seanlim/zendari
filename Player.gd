extends KinematicBody2D

const GRAVITY = 15
const ACC = 50
const SPEED_UPPER = 210
const JUMP_HEIGHT = -270
const DOUBLE_JUMP_FACTOR = 1.3
const UP = Vector2(0,-1)


var enabled = true

var motion = Vector2()
var friction = false
var doubleJumped = false

# Rewind
var rewinding = false
var shader

var hasKey = false

func _ready():
	shader = $Shader.get_material()

func _process(delta):
	$Key.visible = hasKey
	if rewinding && !$RewindSound.playing:
		$RewindSound.play()
		$RewindSound.pitch_scale -= 0.001
	pass

func _physics_process(delta):
	# REWIND 
	if rewinding:
		# Cuts player motion
		motion = Vector2(0,0)

		$Camera2D.shake(0.8, 20, 2)
		shader.set_shader_param("rewind", true)
		$RewindParticles.set_emitting(rewinding)
		$Music.pitch_scale = 0.8
	else:
	# NORMAL LOOP
		shader.set_shader_param("rewind", false)
		$RewindParticles.set_emitting(false)
		$Music.pitch_scale = 1.0

		# Gravity
		motion.y += GRAVITY
		$RewindSound.stop()

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
			doubleJumped = false
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT

#  REMOVE DOUBLE JUMP
		# elif Input.is_action_just_pressed("ui_up") && !doubleJumped:
		# 		doubleJumped = true
		# 		motion.y = JUMP_HEIGHT/ DOUBLE_JUMP_FACTOR # Double jump

		else:
			motion.x = lerp(motion.x, 0, 0.2)
			$Sprite.animation = "jump" if motion.y < 0 else "fall"

	motion = move_and_slide(motion, UP)
	pass

func die():
	shader.set_shader_param("died", false)
	get_tree().reload_current_scene()	
