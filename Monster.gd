extends KinematicBody2D

export var GRAVITY = 15
export var ACC = 50
export var SPEED_UPPER = 200

var enabled = false
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
	motion.y += GRAVITY
	motion.x = ACC 
	motion = move_and_slide(motion, UP)
	pass

func top_collide(object):
	if object.name == "Player":
		object.motion.y = object.JUMP_HEIGHT

func side_collide(object):
	if object.name == "Player":
		object.die()
	else:
		ACC = -ACC