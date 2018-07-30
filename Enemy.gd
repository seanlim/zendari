extends KinematicBody2D

export var speed = 200
export var enabled = false
export var bounces = true

var y_pos = 0.0

var rewinding = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	y_pos = self.position.y
	pass

func _physics_process(delta):
	self.position.y = y_pos
	if rewinding:
		move_and_slide(Vector2(0,0))
	else:
		if enabled:
			if self.is_on_wall() && bounces:
				speed = -speed
			move_and_slide(Vector2(speed , 0))
	pass


