extends KinematicBody2D

export var GRAVITY = 20
export var ACC = 50
export var JUMP = 1.0
export var one_way = false
export var disposable = false

var enabled = true
var rewinding = false

const UP = Vector2(0,-1)
var motion = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$"Horizontal Collision".connect("body_entered", self, "side_collide")
	$"Vertical Collision".connect("body_entered", self,"top_collide")
	pass

func _physics_process(delta):
	# Update game logic here.
	motion = Vector2(0, 0)
	if enabled:
		# Sprite
		$Sprite.flip_h = ACC < 0

		if ACC != 0:
			$Sprite.animation = 'moving'
		elif is_on_floor():
			$Sprite.animation = 'idle'
		else:
			$Sprite.animation = 'falling'
		motion.y += GRAVITY
		motion.x = ACC 
	motion = move_and_slide(motion, UP)
	pass

func top_collide(object):
	if _will_interact_player(object):
		enabled = false
		object.motion.y = object.JUMP_HEIGHT * JUMP
		$Sprite.animation = 'die'
		if disposable:
			self.die()

func side_collide(object):
	if _will_interact_player(object):
		enabled = false
		$Sprite.animation = 'attack'
		object.die()
	elif !one_way:
		ACC = -ACC
		
func _will_interact_player(object):
	return object.name == "Player" && enabled && !rewinding
	
func die():
	queue_free()