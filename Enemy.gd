extends KinematicBody2D

export var speed = 200
export var activated = false

var rewinding = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if rewinding:
		move_and_slide(Vector2(0,0))
	else:
		if activated:
			if self.is_on_wall():
				speed = -speed
			move_and_slide(Vector2(speed , 0))
	pass


