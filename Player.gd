extends KinematicBody2D

const GRAVITY = 20
const ACC = 50
const SPEED_UPPER = 250
const JUMP_HEIGHT = -400
const UP = Vector2(0,-1)

var motion = Vector2()
var friction = false
var doubleJumped = false
# Rewind
var rewinding = false
var shader

func _ready():
	shader = get_node("RewindShader").get_material()

func _process(delta):
	if rewinding && !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	pass



func _physics_process(delta):
	# REWIND 
	if rewinding:
		# Cuts player motion
		motion = Vector2(0,0)

		$Camera2D.shake(0.8, 20, 2)
		shader.set_shader_param("rewind", true)
		$RewindParticles.set_emitting(rewinding)
		$Music.pitch_scale = 0.6
	else:
	# NORMAL LOOP
		shader.set_shader_param("rewind", false)
		$RewindParticles.set_emitting(false)
		$Music.pitch_scale = 0.9

		# Gravity
		motion.y += GRAVITY
		$AudioStreamPlayer2D.stop()


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
			#rewinding = false
			doubleJumped = false
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT


		elif Input.is_action_just_pressed("ui_up") && !doubleJumped:
				doubleJumped = true
				motion.y = JUMP_HEIGHT/ 1.5 # Double jump

		else:
			motion.x = lerp(motion.x, 0, 0.2)
			$Sprite.animation = "jump" if motion.y < 0 else "fall"

	motion = move_and_slide(motion, UP)
	pass
