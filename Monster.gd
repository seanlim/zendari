extends KinematicBody2D


export var speed = 200

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Area2D.connect("body_entered", self,"area_entered")
	pass

func _process(delta):
	# Update game logic here.
	pass

func area_entered(object):
	print(object.name + " entered")
	if object.name == "Player":
		object.motion.y = object.JUMP_HEIGHT * 2.2
	