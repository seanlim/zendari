extends KinematicBody2D

var GRAVITY = 15
const ACC = 50
const SPEED_UPPER = 210
export var JUMP_HEIGHT = -280
# const DOUBLE_JUMP_FACTOR = 1.3
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
	# Pause menu
	if Input.is_action_just_pressed('ui_pause'):
		get_tree().set_pause(true)
		$cntr_pause.show()

	$Key.visible = hasKey
	if rewinding && !$RewindSound.playing:
		$RewindSound.play()
		$RewindSound.pitch_scale -= 0.001
	pass

func _physics_process(delta):
	# REWIND 
	$RewindIcon.visible = rewinding
	$CollisionShape2D.disabled = !enabled
	if rewinding:
		$CollisionShape2D.disabled = true
		# Cuts player motion
		motion = Vector2(0,0)

		$Camera2D.shake(0.8, 20, 2)
		shader.set_shader_param("rewind", true)
		$RewindParticles.set_emitting(rewinding)
		$Music.pitch_scale = 0.8
	else:
	# NORMAL LOOP
		var animation_ = 'idle'
		shader.set_shader_param("rewind", false)
		$RewindParticles.set_emitting(false)
		$Music.pitch_scale = 1.0
		$Music.volume_db = -3.33

		# Gravity
		motion.y += GRAVITY
		$RewindSound.stop()

		# Controls
		if enabled && Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACC , SPEED_UPPER)
			$Sprite.flip_h = false
			animation_ = 'run'

		elif enabled && Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACC , -SPEED_UPPER)
			$Sprite.flip_h = true
			animation_ = "run"
		else:
			motion.x = 0
			friction = true

		if is_on_floor():
			doubleJumped = false
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
			if enabled && Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT

#  REMOVE DOUBLE JUMP
		# elif Input.is_action_just_pressed("ui_up") && !doubleJumped:
		# 		doubleJumped = true
		# 		motion.y = JUMP_HEIGHT/ DOUBLE_JUMP_FACTOR # Double jump

		else:
			motion.x = lerp(motion.x, 0, 0.2)
			animation_ = "jump" if motion.y < 0 else "fall"

		$Sprite.animation = animation_

	motion = move_and_slide(motion, UP)
	pass

func die():
	$Camera2D.shake(0.9, 20, 2)
	$Shader.get_material().set_shader_param("died", true)
	$DeathSound.connect("finished",self,"on_timeout")
	$DeathSound.play()
	enabled = false
			
func on_timeout():
	$Shader.get_material().set_shader_param("died", false)
	get_tree().reload_current_scene()	
